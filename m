Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794115563;
	b=wJ3ZKEAYVN3AGcjddAW/g+FqhRYuI63OvxU7C+ADnqneSKSUt+im6vIRs0kVWIrMthG5
	 9btfmABv27E3/B29YxwJKYpjxwz42zZdUF89VSIzXn6MelM2cgYkG18Mh+s/pVezP3zbh
	 tWS9xe4NSVy9mbxuNvz8MQznU4SqMv4VF+22bH0vrOGqxHRnhrg3b7rRZz+ln78t42eD8
	 DHOFuiFIIQPqW1mCqli4WjEZhTYvYVfPPxfjP8VqUVEPwhI6Di05m2pG6awulWUvxHNl2
	 krU5J0QkXuFOIZIcZ2xOE09Y748JsOBpxakszfb/fgMGqtKrF6HRcB91MR33Su8aZxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794115563;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:User-Agent;
	bh=yYYx8CYb0Oifw4OS22N4OnxYLzgiXng9euC639iE3pM=;
	b=NKS9QlHncvxCTdgLCJ1Z9n6mk7at5pdJaHV5fH8M9v2B+5vvxVeTuKArGof+yZhGWO1P
	 9Z7mn0UXhXH6aT1EIpMTvxMweImno9R+8EX1sj/bLVv/ZKrNDZ53+V4KF43idrNZqKn94
	 ytONuFOc9k3oaiet1MVJKMigSaMzG1S98WdzvN47mfUo39o1WXn4+ZW2C5MNYJWi7MXTf
	 56KRGx37s/6hwOg/hUzixFVaBQD5aiOuHwgC+kQbRmIE7CkNmfO3Kk/PeRcc/DQE6ke1s
	 tIdJ2FyxstmL+q4u32sdlFJWTMyky5vFpYKS5cowfDag8wrXzS5eY32azeO1sRPloVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=R2cpDYMv;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A25606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 05:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14A25606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=R2cpDYMv
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a39e5161c1so106943b3a.3
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 21:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794115562; x=1794720362; darn=vger.kernel.org;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yYYx8CYb0Oifw4OS22N4OnxYLzgiXng9euC639iE3pM=;
        b=R2cpDYMvaElTwaGHkw9bAivNBI0bDal4qZ/vbhEXMRB5BjiKWCKqCQOuzHwVrVqzuI
         9VWHroSS1H+Nyo39smpN4/UQIlVL72MMAelgVucT36FiracBCgbjNH0spI9pX2Eu/z1I
         MfMdzECwkDQjhzM8TycxgS7wJHBuxWOSANuPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794115562; x=1794720362;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yYYx8CYb0Oifw4OS22N4OnxYLzgiXng9euC639iE3pM=;
        b=gecq6EL41QPN0yOqzz0hGKS9Rp7smnHCLbnxPpfBV73+qWyb5g02IITKQOdJ+ArYsN
         4k3GwP4ozSUFjx9XYyXZmWhpL2ldHPoVSxcgjjuYZat9p6h3dhBskBrHkyndEfC1eeRe
         HsCklff36hmZ15qJNTHwpDR/oBSARCz6vLbho+fTrvXGzw5Jk2KotGN+9brjhEvUT+QM
         2KrNrsLaIyTMXO28hVB1UdYSGQVq1a8JzWmP0PceAQIC3VuKgXbmZwUJhVnaci24XGVN
         HuOcnkkSxpNbFCPJYRXGT8Pt8nW7fDOznHy53YnI6ri60SHGXxZ+MkcTgmXWCMzYGHtx
         DGtQ==
X-Forwarded-Encrypted: i=1; AL+hErGTPykJEqVLKzFO7KqRMyOR5lPbTCYNyAb77FEJou1rHYgWBS24sk9hnZUNANQ3gdAGUWjAa70=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VA3GA3veQ5Gr8A4lCdNnQfGw5ru2SFzSVliEI/YUzzPdw9Jf+
	DDCRTR20jEo34jtJjQ2vbMHPxzRi2FXPlg37rF11IMoe7VxybAxCcXg1qtqmmbZ98Fs=
X-Gm-Gg: AYBFou2FqsS3ztdOurviyr9Isi0Im726V9JU+OhzF316m4q5DrRKQJFVPn5Pu1HVXZn
	cXe/uSAHR1YUE3kTlOxKUKSixmkY/x8DDTb9KPLaexMOvTKruHyPg3chx39WNeehftNvpR8J0Wu
	z+sW8Nwe6uBD/+X191E7YCyHtrMJHJdPRH0AdGutBFvk18EgW8Ov8+5ptSkgJegPgPi7/Ox/06M
	iJs8uNgUiU0N7AngscrQIaLf7M+jjiKm5VIFI32hzo+qjViziWx2uifsK0RbmBpkDC4QMShO8e0
	BCuAJsVAPs4rZuQDoXIWsq040irUjBnGvWtWcjevUDVqkcyVk3lGWROrNN9PfjW7g21FsyHg8ls
	J2NIrNzIvseCa4+U/5rrCRFI4rEUuv5/Snq/wQUQcnDb0U4tzIlX1LConNBj9fsM+WnkPvsRlU2
	A7Fv/fnnKBirAB+ONMb8zPi/7DqMXTECcw6f4EuTsRe6PzMzrFsHTjvDXQZRDJO0+pcHWPXKwkh
	YAmU87WEYSl4rp84Osx4tkWNLVYk2uEUkoyry4bAbVPqH4L3gb+lJ1VEgetau8hq/pp0Z9Lh1XS
	l2uFHsRJ7TPMkfkACdxMvgZt53612gfc5JBBR1aGGgqwoLNe6Ya8rSwg/X9s2xZvajSL7IBI17k
	N3JE+VID7yBq+Unhz5f1X95gEN7KJO4VEjF/PcBAapxLY+xvcKpqRT6stvk+6QnwjZZf7Mjzo73
	lPxkuZImSuX5SX0OF4KlO/5zOk/6HG0/7CRQlkb2nq5fbBFcT0W3aU
X-Received: by 2002:a05:6a00:3313:b0:890:a995:1f61 with SMTP id d2e1a72fcca58-8b66ef0603fmr598502b3a.15.1794115562390;
        Sat, 07 Nov 2026 21:26:02 -0800 (PST)
Received: from localhost ([50.175.87.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b64a2e7b94sm269484b3a.57.2026.11.07.21.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 21:26:00 -0800 (PST)
Date: Sat, 7 Nov 2026 21:25:57 -0800
From: Chris Down <chris@chrisdown.name>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jeff Moyer <jmoyer@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: [PATCH] x86/mm/pat: Don't leak reservations at the physical address
 limit
Message-ID: <avAH5XMCbIWvdD8R@chrisdown.name>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

memtype_reserve() and memtype_free() pass their physical addresses
through sanitize_phys(). Both take an exclusive end address, but
sanitize_phys() expects an inclusive one.

So this has the effect that for a range that ends exactly at the top of
the physical address space, the mask turns the end into 0.

As a result the ISA range check succeeds and memtype_free() returns 0
without removing the reservation. A new reservation that overlaps
existing entries takes on their memory type, so the stale entry goes on
choosing the cache mode for that range.

Let's fix this by doing some annoying off by one twiddling.

Fixes: aeef8b5089b7 ("x86/pat: Pass valid address to sanitize_phys()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chris Down <chris@chrisdown.name>
---
 arch/x86/mm/pat/memtype.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index cf94fb561310..007d833b4c00 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -613,7 +613,7 @@ int memtype_free(u64 start, u64 end)
 		return 0;
 
 	start = sanitize_phys(start);
-	end = sanitize_phys(end);
+	end = sanitize_phys(end - 1) + 1;
 
 	/* Low ISA region is always mapped WB. No need to track */
 	if (x86_platform.is_untracked_pat_range(start, end))

base-commit: 5cdc3746fa163fb4e8d05fa3cabf46bc6aa7df75
