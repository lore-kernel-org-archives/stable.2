Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045827;
	b=wHdlpgXoZmHLX2b+T2hS1WL8ZRt5At2IzUjFQlkFG0QtallhP60hoYC8fkV+7A4fvCkn
	 ACJUc5S+cfqznz5yKB7n8LHk1b1lG9LXPAR1PTaZxbvLcbMkDW4C99FdQeZKAlokLUqRN
	 qf2VEVQDAYUCsV1jAq0FCyLmYhR00YAGusPKy+D0/7Onzd0VLFiWgZWK2XotCRpYhJ6U1
	 6s61rpD9UcPZW23EIKc8MIU0uxWzJMHPa+ACcOQVMHc8qnceO+xtrQEpBi58kYWU+BmuM
	 M5B7K3LT/p/9C4TwwVjv5JJleLri4814suPj2lUVDRLdos7VmPY4Hobl3tPBSjTm1tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045827;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vrzuVIPl5O2c+P4JqcjqK90ye6EG5LqzKE9YrZguU88=;
	b=seBr9EBfUTk4+m7VHCOgRyFaiDeA42BVs/a44ifie3ReTMTo7fZOzz1NMgVFDmUcmAy5
	 +Kh7sq9YS7SCG0p1Afv3EdrCIN3pa2bJlNh1o6WRJUnq3YtAf6uCQOZ4NwbJ+yNUrFZje
	 7CKHJI4mcVMM6ExFi2fMw7Sd9BlIWrdqjRSko6wAkdugU4V3/dEVKxpD6+X4r2Jiob0he
	 gxesQHdzoa5RCpHTfRkEB1IdmCiKObj5qA/5wA9aa1Czlu6UZk4thEgcrWoxkb5BLbYdm
	 AXINJ7KLQSfgAr30ywz/whxe6+6RbJmsTqoGuH74SxksPOz77dJRzTFKK4TNTbjxrlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iesh0a4a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A36606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iesh0a4a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D1D1F0089F;
	Sat,  7 Nov 2026 10:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045827;
	bh=vrzuVIPl5O2c+P4JqcjqK90ye6EG5LqzKE9YrZguU88=;
	h=From:To:Cc:Subject:Date;
	b=Iesh0a4awEF8C86N5L4pn0ZoTioBIFQ1ntqq+BWKOyItYGgo1dfDJ2sh5ZOCAoG6T
	 zH2L0l02gWT2d/jxhuWqYtpTQq545pfmgLSTl23+LN+W4vRuzidMS2wKfnn6lTghT5
	 wgfhQwYLhJNBlcn94tUSkC1lO6GZeI7cwmjhMcguTLU17yfL62vA0OmhiZJrAlTEEV
	 GPns5Cz3tfbS2pbCuf3mYDEArdOTznGfRYiA9lSjPaspV9pCszvMyUrP8YqMUEgtlG
	 LTwrAE7c2pmAuToczBsmXtwe3zq6v5DYOtE/jqbyae5KJ2ETwSTRmtHmNsyCZKQ6WA
	 PoGo89D+9lU9w==
From: Sasha Levin <sashal@kernel.org>
To: krzysztof.karas@intel.com,
	andi.shyti@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/i915/gem: Prevent overstepping exec array boundary" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:03:46 -0500
Message-ID: <20261107050345-failed-7.3-2a0158925fb9@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 2a0158925fb943c7ba8f3216e2734952128defc9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050345-failed-7.3-2a0158925fb9@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 2a0158925fb943c7ba8f3216e2734952128defc9 Mon Sep 17 00:00:00 2001
From: Krzysztof Karas <krzysztof.karas@intel.com>
Date: Fri, 11 Sep 2026 06:11:45 +0000
Subject: [PATCH] drm/i915/gem: Prevent overstepping exec array boundary

It is possible for eb_relocate_parse_slow() to call kvfree() on
entries outside the original exec array during following
scenario inside eb_relocate_parse_slow():

1) eb_copy_relocations() allocates as many as eb->buffer_count
   copies for exec entries;
2) eb_parse() appends up to two VMAs, right after incrementing
   eb->buffer_count;
3) cleanup under "out" label uses this incremented buffer_count
   to release relocation pointers from exec array via kvfree(),
   not from VMA array.

To amend this problem, ensure that relocation cleanup uses the
original exec object count, excluding the VMAs appended by the
command parser.

Fixes: 8e4ba491b0ba ("drm/i915: Parse command buffer earlier in eb_relocate(slow)")
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
Assisted-by: GitHub-Copilot:gpt-6-astra
Cc: stable@vger.kernel.org # 5.10+
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Link: https://patch.msgid.link/20260911061145.3535489-1-krzysztof.karas@intel.com
---
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index 1f303d4eaa4d4..d5aadced7da0c 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -1766,6 +1766,7 @@ static int eb_reinit_userptr(struct i915_execbuffer *eb)
 
 static noinline int eb_relocate_parse_slow(struct i915_execbuffer *eb)
 {
+	const unsigned int count = eb->buffer_count;
 	bool have_copy = false;
 	struct eb_vma *ev;
 	int err = 0;
@@ -1868,7 +1869,6 @@ static noinline int eb_relocate_parse_slow(struct i915_execbuffer *eb)
 
 out:
 	if (have_copy) {
-		const unsigned int count = eb->buffer_count;
 		unsigned int i;
 
 		for (i = 0; i < count; i++) {
-- 
2.53.0




