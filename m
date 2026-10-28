Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=64.106.246.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793174856;
	b=zA3pWj6hkgpcZFkgVqAaXJaS531xykmfktQErljcf7KYJEiw4luFp5UaNNkSAkBiOUut
	 rzlj7Vm752BAYvwBCKYNzjC986rI/Ab4qqDX4Vap5/2XfZbyR8RSJZy56U+TBlHqyowJT
	 oYVR6HkdW7hY7pimF7XgVi8mi8NaNePpQx1TO8B4WQOtF0KwJ2ybv/TaBByvuUSGnofaA
	 ABQWajLxMgIwjwHQ+ybr6TxtISfVF2Cq3lCTo5Q18rn8OQVvv3/CHia/Tq1R/yhcVXAjK
	 3DDtAA7//HzWKPwXRakjCseAWUxURv8VDfqD2RgjC1Yd1hKZhY9y9pam+fVOHWVLjxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793174856;
	h=DMARC-Filter:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=h+iT6wmE4ByXBF7sQha5D04NNu/JKAHodJVSAbVAhYQ=;
	b=XmTqRMaXrjoTZ8lu0xsoFI/FFiaElkWcu17aNqaUF1MNFxqYibI0bUvvvVvi4OTtNizI
	 J90adbzIvCoL0KNppSojHst6q6dDz6x8V7W0WTF4TvdL5nA/HLnJOzBSOTotql/T5Df03
	 2M1mcyfCZQlOtl2RjCdkFAKrMZ+qQ0BkYJbrF89S8KV1Wk8hqlKNIkZcAAJJlTQ015N4b
	 sHY/ypYg/kVWBZth7AXANUlhhWYdp/MOKI2ERcvn92Hs07fGMrImoQB6IJA/mPjkryudi
	 v3jVfQOIB9iFsbWw9+G6msBvOeiMAOjfU4D/ZRR98S4QvUIYNalTckKOBoRRxuyutzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	arc=none smtp.remote-ip=64.106.246.77
Received: from mailsc.amlogic.com (unknown [64.106.246.77])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F67606A31A;
	Wed, 28 Oct 2026 08:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9F67606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from XA202100-0024.amlogic.com (10.88.19.246) by mailsc.amlogic.com
 (10.8.11.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 28 Oct
 2026 01:07:32 -0700
From: yao zhang1 <yao.zhang1@amlogic.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-mm@kvack.org>,
	<linux-security-module@vger.kernel.org>, <selinux@vger.kernel.org>,
	<ebpqwerty472123@gmail.com>, <paul@paul-moore.com>,
	<stephen.smalley.work@gmail.com>, <yao.zhang1@amlogic.com>
Subject: [PATCH 5.15.y] mm: call the security_mmap_file() LSM hook in remap_file_pages()
Date: Wed, 28 Oct 2026 16:07:18 +0800
Message-ID: <20261028080719.1821-1-yao.zhang1@amlogic.com>
X-Mailer: git-send-email 2.56.0.windows.2
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mailsh.amlogic.com (10.18.11.5) To mailsc.amlogic.com
 (10.8.11.35)

From: Shu Han <ebpqwerty472123@gmail.com>

commit ea7e2d5e49c05e5db1922387b09ca74aa40f46e2 upstream.

The remap_file_pages syscall handler calls do_mmap() directly, which
doesn't contain the LSM security check. And if the process has called
personality(READ_IMPLIES_EXEC) before and remap_file_pages() is called for
RW pages, this will actually result in remapping the pages to RWX,
bypassing a W^X policy enforced by SELinux.

So we should check prot by security_mmap_file LSM hook in the
remap_file_pages syscall handler before do_mmap() is called. Otherwise, it
potentially permits an attacker to bypass a W^X policy enforced by
SELinux.

The bypass is similar to CVE-2016-10044, which bypass the same thing via
AIO and can be found in [1].

The PoC:

$ cat > test.c

int main(void) {
	size_t pagesz = sysconf(_SC_PAGE_SIZE);
	int mfd = syscall(SYS_memfd_create, "test", 0);
	const char *buf = mmap(NULL, 4 * pagesz, PROT_READ | PROT_WRITE,
		MAP_SHARED, mfd, 0);
	unsigned int old = syscall(SYS_personality, 0xffffffff);
	syscall(SYS_personality, READ_IMPLIES_EXEC | old);
	syscall(SYS_remap_file_pages, buf, pagesz, 0, 2, 0);
	syscall(SYS_personality, old);
	// show the RWX page exists even if W^X policy is enforced
	int fd = open("/proc/self/maps", O_RDONLY);
	unsigned char buf2[1024];
	while (1) {
		int ret = read(fd, buf2, 1024);
		if (ret <= 0) break;
		write(1, buf2, ret);
	}
	close(fd);
}

$ gcc test.c -o test
$ ./test | grep rwx
7f1836c34000-7f1836c35000 rwxs 00002000 00:01 2050 /memfd:test (deleted)

Link: https://project-zero.issues.chromium.org/issues/42452389 [1]
Cc: stable@vger.kernel.org
Signed-off-by: Shu Han <ebpqwerty472123@gmail.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
[PM: subject line tweaks]
Signed-off-by: Paul Moore <paul@paul-moore.com>
(cherry picked from commit ea7e2d5e49c05e5db1922387b09ca74aa40f46e2)
Signed-off-by: yao zhang1 <yao.zhang1@amlogic.com>
---
 mm/mmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 273e06dad3c6..7f357de8f4d6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3047,8 +3047,12 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 		flags |= MAP_LOCKED;
 
 	file = get_file(vma->vm_file);
+	ret = security_mmap_file(vma->vm_file, prot, flags);
+	if (ret)
+		goto out_fput;
 	ret = do_mmap(vma->vm_file, start, size,
 			prot, flags, pgoff, &populate, NULL);
+out_fput:
 	fput(file);
 out:
 	mmap_write_unlock(mm);
-- 
2.46.0

