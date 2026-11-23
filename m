Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795434119;
	b=z5hsAVcPVeq7OsHkN+W2T6SQ1nZl5QgNb0EADVc2EAH2IiC2oEkqYLA0bsNBjrl3IL/I
	 P+UD77x8pZ5YxDuDdVYrnfeDm8xjgA51NSIu4luVG0CHLvmVUh7+8MWASPjBYnB5zwY5k
	 nuRwbJvUNBTtbWQOuMSUYy0r85BrcvtfEtEBdvRe8PAtI82LXxhcxxNYIUqcCj0Z4+UWE
	 5gf9hIa2PQYU5dy2wpTo3zJq0C6tXfXGN+Y+6GgalsUNNtoM7HMg0FrzpBfi+TffJpwbS
	 0wIssmFx+H9hkEypQi9mlAX+8So4lVSk4hwlyeGMmsa0yk0R2FcIrxI7leVaw4sEW6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795434119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:User-Agent:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2pe6kDm4hsS2/g1veafnEkrqROCAZR+w7+EWRL5nhP8=;
	b=fZVt0UvvgVS7kAo97ahM6sKUS19k7qc+kmuQDpWu2f6afi502p9g75pdaDyAGMMEYhAL
	 nTNLeG1sGBtxisXXogHpGDNOkmG9gVSAC/esZJycfe6gJBLAk5Fp0BUz5MDrsHawORbf3
	 OFKhYIz7NGP+laEmFaw7o02N0Cz1WMdW9dtxc+50a/FtjqSP3li7U5z7ndnKcebbB69iq
	 BcCdv6lKUCCrQVSOg+H26cFWjhBe0RAPVuDLHq99+t/LMqZoJ4JS5pLaC/xnmK3hKU+Go
	 nGUCHGENpJxow84Gx/lRV4LZ07xwb7+Qi3zjoFozkTa5tEmlFodpOmtlsMIO2FEnrsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="OS/aVhwd";
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A060606A31A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 11:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A060606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OS/aVhwd
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b487f44ee0so520419a91.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 03:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795434118; x=1796038918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2pe6kDm4hsS2/g1veafnEkrqROCAZR+w7+EWRL5nhP8=;
        b=OS/aVhwdym1CPLcpE/l2Ov5qlxj7s1kf99Is6g9iK5/4W69jCz7QmDSH1VMgQo6Sz4
         NW6NfU4oYBQUlvOBbQJDuBihUhVyIKkNmNm8T06kPqsa3j9hq3lFx/nclhFvG5rL3kwx
         458FzUOKmig85x6+o6kYq6lkJNOceJD6pV3ydxF42fs47ROuaqiyBZkZOJW6r7HVeNIq
         cGsAa9wI9YVcNtxmSEex3zU0Vvii9Ou1l95R+XRFJ7q7pWp4C67EC38MgCFReFBCU6Xu
         5lrEF0j7QPLtc0+BRoVfoJBnaTQpi6ZjdLt7b08bS09pPhQkwkZZg/+p3CI8miZLd4jY
         zq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795434118; x=1796038918;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2pe6kDm4hsS2/g1veafnEkrqROCAZR+w7+EWRL5nhP8=;
        b=I6QZImzMr8YBBzUNB/bwnJ3V3LgSdcdPG6sYgHdi+qqJTwOJgtteP6Udnrqaq6ZOWn
         VfF5Zwr2Mmo6Bx3YYMbsM3VaBr8bAvYplpLNZUXnhMZcZYqYZI4Qn4YLJRywVt34sUAD
         Lbu/gfs153+IjLfZu1tvi2v4NHUN5NlmdCYDH3HoqE2GIVJW3ENAyIj8dKDHoZ0w1P6l
         QLv9TzaFcdtXLHQXJaxADbEVAxwcSMF4x99fS2W2PoTPVahcsnEoSsg88BVROqY6AwEB
         zFQWd3ttEHkQP5XRJUUplDBMta8ri5LtgXp4lfRIy/Q07G9k+6SXZwRvMlj6rmV6CkUj
         V9/g==
X-Forwarded-Encrypted: i=1; AL+hErF77npNYcLBctOZg6rCsBHb+dm/vwhKaSgVUNZ3uOy8Jcqux7VSWZ6d3c8Tt76Ge71pseXeqOA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+NlqcNPTj4+F6pEnS8oSacdbh7jolWZaLnTEt4QTk7zfkT5UeM
	xtt7FC7lUlp+84r68vfIahNritTgk610/7sZFYPGlrbPF4RfWvLHxgrX
X-Gm-Gg: AZFdTZfcOXpWynlyLGkJVIZEAZHBs5d3+7eHKU+hgBljHoAZySt3uHoqLmhOLT4NDT6
	Pericz8ApStd4VTKdhvsOH8kY+rvPuE84fEIj7Lsd3+IFvOsA1lTH7X1JjL7NmeMh8WCbIzopEw
	Ow/h3pGo+aqZR021gfUFwsvew8OIpPAZudkS8SCzWTWjD5uynQSX9Ze1HhKMRS9hAQ9KwRrofN3
	IO6033ea/u6z0tlDXt1HPW4/L8irO9xz+Y9rLPxgcELICAcWiaBUmgpZKITCK7epYwaYWdAp+HP
	EssTrFb4uVENsQWmvUVsLlvHnvh8uYIVDKefFclrB96fUgR1i2zeGhaUnHTqqHCp9NUVtzgsozm
	IVpP0nCyT+pBRh2Z+zMuDGDCM5S9NbRk03PqgDjDVLH5wvjyI83/s6cepzWgNWMwRa/NkaQOBxG
	0J7Um917Zs/udnFtF5kFaoitqkcsu3uqAnUWy5vLzFqbNUF8P8fVfTiscQSRYwmQ0b3ZISK/RrW
	C4JPSjHotqKUKQjzOSl+RKioNSS1OUMgYVQiVIlp1ke5HZEfPQ6t3H19lqgFUz3Vh2iGhWPXAmv
	ZY4SsNwAUBWxXEdYxNAyIhFoPGPYa8ETIanUz//M0Z3UBCK0tjiaVu+muQxUgOSfltX7IoLZMA8
	j8h4I6ed8VPPcFUlOKtPjIyYcGUvZ7cJE8655WFuX5DEyNodYU9+cUPo3e/xHORXnAvyRJOA9oW
	XVC+k2YLP1ZXlVdpf3rGJphiprgimYhFCkrt4PtVI=
X-Received: by 2002:a17:90b:4d89:b0:3b4:3c33:3e5d with SMTP id 98e67ed59e1d1-3b43c334caemr4444363a91.67.1795434118309;
        Mon, 23 Nov 2026 03:41:58 -0800 (PST)
Received: from mercury.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b8c2fcesm5775530a91.4.2026.11.23.03.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 03:41:57 -0800 (PST)
Date: Mon, 23 Nov 2026 20:41:54 +0900
Message-ID: <87v75nsrjx.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: brad@sim.vu
Cc: akpm@linux-foundation.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	david@kernel.org,
	surenb@google.com,
	shakeel.butt@linux.dev,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/nommu: keep the maple tree in step when mremap() resizes in place
In-Reply-To: <20261121083139.803682-1-brad@sim.vu>
References: <20261121083139.803682-1-brad@sim.vu>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/31.1 Mule/6.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: multipart/mixed;
 boundary="Multipart_Mon_Nov_23_20:41:52_2026-1"
Content-Transfer-Encoding: binary

--Multipart_Mon_Nov_23_20:41:52_2026-1
Content-Type: text/plain; charset=US-ASCII


Hello Brad,

On Sat, 21 Nov 2026 17:31:39 +0900,
Brad Hawthorne wrote:
> 
> On !MMU, do_mremap() resizes a VMA by writing vma->vm_end and nothing
> else, so mm->mm_mt keeps the old extent.
(snip)
> Sashiko's review of Hajime Tazaki's nommu series found the stale range
> in July, and his fixes and RFC since then cover it [1][2]; review asked
> for a minimal fix-only patch with a Fixes: tag [3]. This is a minimal
> version of that fix.
> 
> The consequence was reproduced and this patch drafted with an AI coding
> assistant (Claude, Anthropic): it reviewed mm/nommu.c, wrote the
> reproducer and ran the board and QEMU tests; I checked the result.
> Stable backports need adjusting: 6.6.y and 6.12.y lack
> vma_iter_store_overwrite(), and 6.1.y nommu uses the ma_state API.
> 
> Link: https://lore.kernel.org/linux-mm/20260710021028.892645-1-thehajime@gmail.com/ [1]
> Link: https://lore.kernel.org/linux-mm/20260813063401.1786548-2-thehajime@gmail.com/ [2]
> Link: https://lore.kernel.org/linux-mm/an77pELeQdW-sTEi@lucifer/ [3]
> Fixes: 524e00b36e8c ("mm: remove rb tree.")
> Cc: Hajime Tazaki <thehajime@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Brad Hawthorne <brad@sim.vu>
> ---
> Hajime, as you asked, here it is as a separate patch with you on Cc.
> Earlier note, and his reply: https://lore.kernel.org/linux-mm/20261120221021.789792-1-brad@sim.vu/

my earlier patchset contains a kselftest case, which tried to test the
issue which your patch addressed.  Part of kselftest is now upstreamed
and I would add the additional one specifically for the case of this
issue (this patch addressed).

Attached is locally tested kselftest with your patch.  Would be nice
to include this in your next spin as a part of patchset.

-- Hajime


--Multipart_Mon_Nov_23_20:41:52_2026-1
Content-Type: text/plain; type=patch; name="0001-selftests-nommu-test-mremap-grow-after-shrink.patch"; charset=US-ASCII
Content-Disposition: attachment; filename="0001-selftests-nommu-test-mremap-grow-after-shrink.patch"
Content-Transfer-Encoding: binary

From 608869187e388e16e4c2b2caf5a174c3a424dd7b Mon Sep 17 00:00:00 2001
From: Hajime Tazaki <thehajime@gmail.com>
Date: Mon, 23 Nov 2026 20:24:08 +0900
Subject: [PATCH] selftests/nommu: test mremap grow after shrink

The existing mremap shrink test covers dropping the old extent.  Growing
a shortened VMA must also store its restored extent in the maple tree.
Shrink an anonymous mapping, grow it back, then partially unmap the
regrown tail and the remainder to exercise that tree update.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 .../selftests/nommu/nommu_mremap_test.c       | 58 ++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nommu/nommu_mremap_test.c b/tools/testing/selftests/nommu/nommu_mremap_test.c
index 6ee89cb25f61..550c21fadbf4 100644
--- a/tools/testing/selftests/nommu/nommu_mremap_test.c
+++ b/tools/testing/selftests/nommu/nommu_mremap_test.c
@@ -133,6 +133,61 @@ static void mremap_shrink_test(void)
 	ksft_test_result_pass("mremap shrink\n");
 }
 
+/* mremap_shrink_test() covers stale entries after shrink; test regrowth here. */
+static void mremap_shrink_grow_test(void)
+{
+	void *addr, *addr2;
+	int cleanup, head, tail;
+
+	if (!nommu) {
+		ksft_test_result_skip("NOMMU only\n");
+		return;
+	}
+
+	addr = mmap(NULL, ps * 8, PROT_READ | PROT_WRITE,
+		    MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	if (addr == MAP_FAILED) {
+		ksft_test_result_error("mmap failed: %s\n", strerror(errno));
+		return;
+	}
+
+	addr2 = mremap(addr, ps * 8, ps * 4, 0);
+	if (addr2 == MAP_FAILED) {
+		ksft_test_result_fail("mremap shrink failed: %s\n", strerror(errno));
+		if (munmap(addr, ps * 8))
+			ksft_print_msg("cleanup after shrink failure failed: %s\n",
+				       strerror(errno));
+		return;
+	}
+
+	addr = mremap(addr2, ps * 4, ps * 8, 0);
+	if (addr == MAP_FAILED) {
+		ksft_test_result_fail("mremap grow failed: %s\n", strerror(errno));
+		if (munmap(addr2, ps * 4))
+			ksft_print_msg("cleanup after grow failure failed: %s\n",
+				       strerror(errno));
+		return;
+	}
+	if (munmap(addr + ps * 4, ps * 4)) {
+		ksft_test_result_fail("munmap grown range failed: %s\n", strerror(errno));
+		cleanup = munmap(addr, ps * 8);
+		if (cleanup) {
+			head = munmap(addr, ps * 4);
+			tail = munmap(addr + ps * 4, ps * 4);
+			cleanup = head || tail;
+		}
+		if (cleanup)
+			ksft_print_msg("cleanup after munmap failure failed: %s\n",
+				       strerror(errno));
+		return;
+	}
+	if (munmap(addr, ps * 4)) {
+		ksft_test_result_fail("munmap failed: %s\n", strerror(errno));
+		return;
+	}
+	ksft_test_result_pass("mremap shrink and grow\n");
+}
+
 static int get_shared_writable_file_expected_error(const char *path)
 {
 	if (nommu && get_fs_type(path) == RAMFS_MAGIC)
@@ -344,10 +399,11 @@ int main(int argc, char **argv)
 
 	ps = sysconf(_SC_PAGESIZE);
 	ksft_print_header();
-	ksft_set_plan(ARRAY_SIZE(mremap_cases) + 2);
+	ksft_set_plan(ARRAY_SIZE(mremap_cases) + 3);
 
 	munmap_shrink_test();
 	mremap_shrink_test();
+	mremap_shrink_grow_test();
 
 	for (i = 0; i < (int)ARRAY_SIZE(mremap_cases); i++)
 		run_mremap_test(&mremap_cases[i]);
-- 
2.43.0


--Multipart_Mon_Nov_23_20:41:52_2026-1--
