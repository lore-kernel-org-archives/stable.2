Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC2138A739
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 12:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791633938; cv=none; b=gbBE1h7jujNKnYEk///O5Vn2Iwaklqcq746CNiKxB38mCRFJ75yZQNg2sMlqjudl06ccVY/cc8nbFHcBdGRTdgzDgp7GH1QNC9BpP8aqa9iBqFWpzs1lXwYtUpycgfwk5C0eaCo4tYMuk4geoq49w6IALc0yk0nkZXCwhYijl1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791633938; c=relaxed/simple;
	bh=NhU5jgmcvMXag+1LZIKhrLyXbOwnznMb5BiggGYZrHo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=u+KpqK4gj613anfA/CRLKVy9ZqgwR7nWwX7LcLeoBXEFJmKvTCwzNUwcmjA5VVTTndVS0R8KMxVhRm4tJtEqjO2v37apIfolRqNRoSws2kNSpagQ3MgqfMeFWumWWpn3KFlaSdR8p+kH9w35agD+t0dEwxw2Zgqz6xV71h/061s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnqGdrnD; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnqGdrnD"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49fbb2acc90so2016565e9.2
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 05:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791633935; x=1792238735; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iDEA6vjah9q6WFHrSqFGiZ6d9YIFPeL6k7zSaUFmLVI=;
        b=bnqGdrnD80j71kaEgpZgFe7Yu0mkaTODiSMunlRgRBpEi1DLHw+31lW4kljTej4Fb/
         kV/OWKKuI0uGQbPAHs4+p68Cu6tsjYjDfDvfYuQmsWUJCAOcCbPxJHIMTEHOF9+DtSTe
         twvNr6HgpmoX0Xkncpcdq+bF4WBnu7oS9ROR9g5JlRRMyJj2YkdW9j759HteQm/89nRP
         Dol81SMYdwSqCm6/0s1ghNawibA59iIWDvBD92A8LWmAi4AXphcp/tPV58GJS0zPLM+8
         hS0f9WAS1Nt8pdAz23yznLbxYqI1zABap5xUO+WtpRdZ6JgpuxBZp95BQh3qtwtASf62
         881w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791633935; x=1792238735;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iDEA6vjah9q6WFHrSqFGiZ6d9YIFPeL6k7zSaUFmLVI=;
        b=V4jWtzq2L5N0k8zmWfD0vkQiR6EB4EfkWknUGMdU/PoViA0CDpqEFt40iR8DB0yOhR
         GC6PneIVLfERWP+cYa1UR2i8zVdlCmWzeklk7qaiOvFjadL6gQi6xEi5DNawmNjQkNYD
         9uLs20zLKu8QUH4Z71pnSEwFWWVLvA4bPy1lbUo0nFMIE6ninD6/io4YmLurhtLdf7bE
         8rSX1BnIHPes/jQBCoHqljBoPFr9sRZMlwT5fJnAFZzz97WwEZxfL5pqKP9pX/J+at6N
         egh2r31c/HbonxIjxOy6kDidcZ7UPxhDbqGBt0/3tO2klOZYgPnCRshRKIKhvWE+VLrO
         r0aQ==
X-Gm-Message-State: AFq9FYKf5EUon4inuXSCSAKkrOrdwVc5kN6QqgqAkHIUk/hij1IvlLdf
	sIGo1Q8aemSesRRTrtFR0sdybNSfMIzEmc2i1NlHXmaLvxogy/P/ZE1+EnSHeL/i
X-Gm-Gg: AYBFou1XI6f1j8qFu93eMMVeV39x4DfeSe4VPcHMDD3dc/qsaC4HG0Df2JAw4diIItT
	SjAgD7Vw+Hb0ryroM4zkSWR+AKl2F9BhNiBR6dzDyrJf3cymj6z2fLA+J6HdkyYa0VIOWfCJm4c
	1+v6idyRh7N1j27t2YkS9rPtPviP48K7elVByMCayLSNGVs18I0cqsnugTkL37e3zFQWlY1dpBj
	CWzCuYmXLLTe17NDO0eBLvIaCAmlP18IJb2pRhcrSWotOYvUY8Iy8SS1Qe7K65SznRQh+WO8dX+
	Y8HXGB7Y8cyp6rD6o3HOKwGO2j1p5S8nzT9b//EwBta7/WHasthOKN+M5knH9f/YGuif9wlLJAB
	IRJQGTshq5gx1tUuiAB97bSu7ucttjMsKMHn/Z9Yg/PeG55iPGSYQBQnASqhoui15MohF7D8mS4
	YzLec7ZJxCZV0/bk2rGNgJWhG5BIvkaD3bpm3Wl6JO0mgJhURj/vyO5gjFRUfzfBmIKa+eL0nYc
	DZB6ECgTkwJRJTmwUK+f1BV70poeUwI2H8nNOgrBKRgNl8jPTu9GTtjANE+7fHvgx1XFafAhEP8
	3tEWA1R4YKO2/CIBuFMUxQT5yUXjGpTTmZwrx/jzWNEQO+IAjNfa1T5wjjoT0l4JnyZLdvUr1jw
	=
X-Received: by 2002:a05:600c:4e91:b0:4a1:7ec7:a479 with SMTP id 5b1f17b1804b1-4a18e4f56bcmr93767975e9.33.1791633934396;
        Sat, 10 Oct 2026 05:05:34 -0700 (PDT)
Received: from imx93-evk.localdomain (dynamic-2a02-3100-9d3f-0d01-48c7-5d76-0ec6-9dac.310.pool.telefonica.de. [2a02:3100:9d3f:d01:48c7:5d76:ec6:9dac])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db94e33d2sm9457467f8f.9.2026.10.10.05.05.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Oct 2026 05:05:33 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mukul Sikka <mukul.sikka@broadcom.com>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>,
	Stefano Brivio <sbrivio@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
	Bin Lan <lanbincn@139.com>,
	XiaoHua Wang <561399680@139.com>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y v2] netfilter: nft_set_pipapo: restore cloned mapping table memcg accounting
Date: Sat, 10 Oct 2026 14:05:28 +0200
Message-Id: <20261010120528.4604-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The 6.6.y backport of commit 69e687cea79f
("netfilter: nf_tables: missing objects with no memcg accounting")
changed the pipapo_clone() mapping-table allocation to
GFP_KERNEL_ACCOUNT.

The later stable backport of commit 07ace0bbe03b ("netfilter:
nft_set_pipapo: do not rely on ZERO_SIZE_PTR") rewrote this allocation
and changed the flag back to GFP_KERNEL. Upstream applied the
ZERO_SIZE_PTR change before the memcg accounting change and retains
GFP_KERNEL_ACCOUNT after both.

nft_pipapo_deactivate() clones a populated set before looking up an
element to delete. If the element is absent, priv->dirty remains false
and the clone is retained. Its mapping tables therefore remain allocated
without being charged to the requesting memory cgroup.

Restore GFP_KERNEL_ACCOUNT for the cloned mapping table.

Fixes: 32bad10de347 ("netfilter: nft_set_pipapo: do not rely on ZERO_SIZE_PTR")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Changes in v2:
- Split the combined 6.1.y/6.6.y submission into one email per branch.
- Keep only the Fixes tag for this branch.
- Refresh the diff against 6.6.158; the code change is unchanged.
- Add fresh build, runtime and matched A/B results for this branch.

Original submission:
https://lore.kernel.org/r/20260831194905.45045-1-kmehltretter@gmail.com/

Testing on 6.6.158: built a minimal x86_64 kernel with GCC 15.2.0
and booted it in QEMU with CONFIG_MEMCG=y. A 64-element two-field
interval set passed creation, lookup, update, rollback, deletion, flush
and reuse checks.

Matched unpatched and patched boots used the same kernel configuration
and initramfs. During a normal update from a memory cgroup, both cloned
mapping-table allocations (512 bytes each) had accounted=false without
the patch. With the patch, both used GFP_KERNEL_ACCOUNT and had
accounted=true. Both variants passed normal set operations without
kernel warnings.

Earlier A/B testing on 6.1.186 and 6.6.155 measured 524,288 additional
charged bytes for the cloned mapping tables of a 32,768-element two-field
set. An unmodified 6.12.107 control already accounted that allocation.

 net/netfilter/nft_set_pipapo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 7c8d28a031ad..4c3bb5d61a3b 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1465,7 +1465,7 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 				goto out_mt;
 
 			dst->mt = kvmalloc_array(src->rules, sizeof(*src->mt),
-						 GFP_KERNEL);
+						 GFP_KERNEL_ACCOUNT);
 			if (!dst->mt)
 				goto out_mt;
 
