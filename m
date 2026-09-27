Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEFE3E4110;
	Sun, 27 Sep 2026 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790511313; cv=none; b=uVxa2muRaIpEzmOtWaK1VfS0WYvS9TP1SDe/8lpkWgexhKtpFgyGR7bNsqXPfdZdU0XejXhXqR3msTPgJAQQqq1CzO9DCydYDNJKhjbdOzf77CAmGQ7HtS/cCVPTuJNRSWsC8cpDUGrt/d00ndGwvOT+4i1qpPDCH5UFUHR1i2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790511313; c=relaxed/simple;
	bh=r9rx+6N6SuEtUm4nMBsWnUslRWZU2295jdiOXrL7Da8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I9ysdnc/3FHcGdO0FzB4zBjO/h2u4rFGAW2UJ4CnZDLeXGV7AozuVxFnkSZoE/di8OvPkp8CGkio5dNWkROUDpU1HuwDjfrMvi3XnswUGgAovz1qXtWqAYSAknWGFL7KJ61vHW/VshUElDgJvtQphrRXFKx2P05J9RpVvtTpyC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=p9ihEWbG; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="p9ihEWbG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Hj
	qo3qdmyTM7os9WaYem4cK+wKOr9qt6tZwESXnC+OQ=; b=p9ihEWbGll9Hah2PmK
	lWlM0Gdz271+/jU6ZOj8oRoBC7SKGuQIZbq8v90K5NwQEvjAeBwpv80uipvFTisG
	1U8cPX0ycaJZJ8ZVUSpbNvSXiqhQFMWihF/tkdkNQ9teSWsfmbHBIOaJ5SgRJaTY
	5RmUJQ5Q+X8qKWG3yBaHOvz8o=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3_0GLCLlq6XfhBA--.13079S2;
	Sun, 27 Sep 2026 20:14:04 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] bpf: Initialize IMA hash helper output buffers
Date: Sun, 27 Sep 2026 20:14:00 +0800
Message-Id: <20260927121400.1188165-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_0GLCLlq6XfhBA--.13079S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF13WrWDXrWDCF47uw1ftFb_yoW8Xr45p3
	ZIg3yqkwsYyFWUK3W8AFWF93WYgFs3XrWUKF4vqw4xtF1UXr1qqFyUWw4Y9F1rAFy0krna
	gF4q93s0v3y8Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi4xR3UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQ0uaGq5CI1SHQAA3f

The output arguments of bpf_ima_inode_hash() and bpf_ima_file_hash()
are marked as ARG_PTR_TO_UNINIT_MEM, so the verifier considers the full
range initialized after either helper returns.  The IMA hash functions,
however, leave the buffer unchanged on error and only copy the digest
length on success.  A BPF program can therefore read stale data from
the untouched portion of the buffer.

Clear the full destination before calling into IMA so every byte is
initialized on all return paths.

Fixes: 27672f0d280a ("bpf: Add a BPF helper for getting the IMA hash of an inode")
Fixes: 174b16946e39 ("bpf-lsm: Introduce new helper bpf_ima_file_hash()")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 kernel/bpf/bpf_lsm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 82c5988417a0..bc08c039dc85 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -168,6 +168,7 @@ static const struct bpf_func_proto bpf_bprm_opts_set_proto = {
 
 BPF_CALL_3(bpf_ima_inode_hash, struct inode *, inode, void *, dst, u32, size)
 {
+	memset(dst, 0, size);
 	return ima_inode_hash(inode, dst, size);
 }
 
@@ -192,6 +193,7 @@ static const struct bpf_func_proto bpf_ima_inode_hash_proto = {
 
 BPF_CALL_3(bpf_ima_file_hash, struct file *, file, void *, dst, u32, size)
 {
+	memset(dst, 0, size);
 	return ima_file_hash(file, dst, size);
 }
 
-- 
2.34.1

