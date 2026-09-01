Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870C643713C
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788275038; cv=none; b=FPy9OPeANe+shvvaoUkDHoEwPW5qdgigpVHuy225AOivcoEA/Vbd2ZXzRaTJLGyMUt9tUEUFMi0sJHmKo4Cxj2lIxrBPx8DwVWe3xhvcfZ5L9FYPhmAa6Z8yZ/TQxwPOtjkUcAMHkb8IjvNr/3Ob1UPZnt2HWXqdjVESrO+bn/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788275038; c=relaxed/simple;
	bh=EV0luyxrE4VBTkjaX8NMlEgGp6/Xt54MDGLWoiypEoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H97vVPGMhzDoBCjTdh7JF8Q8+WanzF15bd6+GQ39EdtQjlUJXfDMMIgCBesAbwjJS++8oORBAIwkLC675ncLGq7i0HdnO1Up+7RC/QRM8IGazP29Vq4sE3dIarz7WV+X+uTx0nLXsqFkod4aDM3y4R+x4EgHDK16jLaTXoUgMTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=Wc/NGc2k; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="Wc/NGc2k"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-848643382fcso5234230b3a.1
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 08:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788275036; x=1788879836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nYjWdRobMhFwnScsH6QAuV5nfOH/dqs6pUr1givzmCo=;
        b=Wc/NGc2kO0hzZ56egklVW7Bp/A+N/J5dMOx8cO+Fat/8MGLbBhMCxs25SAk+snlk24
         GrEvL15mi8KVN3ghZCWWW4yN2zro9/mYHvgvXsVUv+gCPUPnlbxmVGZFfnmY9bvJD0XQ
         VHX+SyydAbVZ+QR2RNX4kF+HeMpFuCWgR9iiPOBibCtYqgbymHit+hu3Q0rZOWprBtDU
         JXW0c4xh8EI4QVDmwsKfBGGxFOYpQodICoYS5E8QyVDprYHy68f1cZMDLldKDLGLWb4W
         wNyRL2G8tcbFv48TtwC9mPIm6ahqYgRZWLoxfzNdtdLVsuZQaou/7ovWS8SBus8OwFaJ
         N07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788275036; x=1788879836;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nYjWdRobMhFwnScsH6QAuV5nfOH/dqs6pUr1givzmCo=;
        b=TMZf/nNOGvSQR0SRW65DfeQIfo/XdsdRHV5Uj0lpJAxiRj60kzknUtv+zhLm7bpj5w
         a2pCTzoKC4AqoMDogpK/1Cqqwvbe2JptaC20LrQhwJX1FlRL3nl4c5krCMbUPcio8KQT
         BeSpbp9uRlutSE/vrMFvjLOx8af+j6jDzrpil9mX7zVk7eHaSA/IWd/iezW/ex77Ob/I
         2cEMZFLK5zWinPB93Tywlv8dEe+hD9vAXBEqnYRM8GYJp/an9JFbPkFNtYezVG0bZ1Gz
         XWkDdCeC0HRmrnKlLyuQ6tBJSEwYGIC1EB2vkzdWxG9lvyphnf7WLkJXcbcLfAplmRah
         hEqA==
X-Forwarded-Encrypted: i=1; AHgh+RpI4Ub/KtQc4zD35xN6Y/ucqeKCVWoXq1gy2d1tvkLiYPow6KxH1gUGi6k6Vwzxqrm4RM6R02w=@vger.kernel.org
X-Gm-Message-State: AFuF++k/iuefhPjCD9xDU0t2nR6PJyKcHWqX++i++X1T0CUHl+j2m+Nw
	v1Gw8PMrnqcuZd75JAH2jgPVkc9ARh2g0Y6/4WvXWrWJgQn6xLZeNMMZUHVc4dSiQDc=
X-Gm-Gg: AR+sD10b/g3jESvscAfbNa3eupQTRJpnI6GxR2eOL1E5yg+jUdWVvNHpSHWsXyE1O18
	Gmni37fg3xYNyoUaBB5Gq1AZaHxE9P5vP+FvhXN43yoCKsj/2tVfENZmU8r+9aO7ParecNgQ0re
	3RLuvRjqJi1YQk4Cbk95UfEIolWn5RE/zJ+60U4rg3RyMsKiGBOGzD3bKKGwX6TuOsCT1BhFzpG
	jCdppWpMPfSylOa9bku6PlQHxvF/ydEbHnM4o0bEf5fF5vcL8n8at0YbrH1tCYlCZ9cxEDjl7+9
	QrZd6B4BcPClBsxHyoBD+QVyW899Bpb4gxXpyrvj5QJlcrDqEiu9Duq/S0WKapLx/V2MqPmY+AW
	3qs0YAst7A5dCHR4JARDj+0AMR2a1k1Ah8UmgUE4hQdXQgeWHhlfDXXOlzndkpk/x2vcPdgopXC
	BEtDYbIs1LkVjdSQ9AM1VRWMtyI4WXVKwsqQerx0zLPJA=
X-Received: by 2002:a05:6a21:a0a:b0:3d0:abdb:de03 with SMTP id adf61e73a8af0-3d7ad788edbmr15943018637.2.1788275035650;
        Tue, 01 Sep 2026 08:03:55 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4c::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f32f727bsm6432687a12.7.2026.09.01.08.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:03:54 -0700 (PDT)
Date: Tue, 1 Sep 2026 08:03:54 -0700
From: Joe Damato <joe@dama.to>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Rukhsana Ansari <rukhsana.ansari@broadcom.com>, horms@kernel.org,
	colin.winegarden@broadcom.com, linux-kernel@vger.kernel.org,
	raphaelcf@meta.com, stable@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH net v4] bnxt_en: Bound SW TPA IDs to prevent crashes
Message-ID: <apbpWrfu3VQu+CUz@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Rukhsana Ansari <rukhsana.ansari@broadcom.com>, horms@kernel.org,
	colin.winegarden@broadcom.com, linux-kernel@vger.kernel.org,
	raphaelcf@meta.com, stable@vger.kernel.org, llvm@lists.linux.dev
References: <20260828190900.1767611-1-joe@dama.to>
 <1c87458d-7d76-4da4-9981-51756cef391b@redhat.com>
 <apa9qofhuatqGTra@devvm20253.cco0.facebook.com>
 <b8b6db7b-353d-4d6a-b0b6-3b5e1be22008@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8b6db7b-353d-4d6a-b0b6-3b5e1be22008@redhat.com>

On Tue, Sep 01, 2026 at 02:10:04PM +0200, Paolo Abeni wrote:
> On 9/1/26 1:57 PM, Joe Damato wrote:
> > On Tue, Sep 01, 2026 at 10:16:54AM +0200, Paolo Abeni wrote:
> >> On 8/28/26 9:08 PM, Joe Damato wrote:
> >>>   - Moved bp->max_tpa_roundup_size init out of the early return path and
> >>>     documented that TPA is unsupported there, as suggested by Michael.
> >>
> >> Clashiko quite convincingly elaborates that the above is not enough:
> >>
> >> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260828190900.1767611-1-joe%40dama.to
> >>
> >> Could you please have a look?
> [...]
> > 3.) "The new assignment sits after the max_tpa_v2 == 0 early return, so on a P5+
> > device whose firmware reports max_aggs_supported == 0, does
> > bp->max_tpa_roundup_size stay 0 while BNXT_FLAG_TPA is set? ..."
> > 
> > Michael commented in the v3 that this is a false positive, hence why I changed
> > the code from what it was in the v3 to this.
> 
> This is the comment I referred to.
>
> AFAICS the problem is that the driver sets
> 
> 	bp->dev->hw_features |= NETIF_F_LRO;
> 
> regardless of the supported capabilities, and that seams to disagree
> with Michael.

OK, after re-reading this here's what I see: NETIF_F_LRO gets added with no
capability check and bnxt_fix_features() won't strip it afterwards. I think
the fix there is to add a BNXT_SUPPORTS_TPA() test, as a Fixes for
f0aa6a37a3db ("eth: bnxt: always recalculate features after XDP clearing, fix
null-deref").

I can send a separate patch for that, but it is unrelated to this patch which
fixes a crash on boot for Thor2 devices.

Maybe you want me to spin a v5 that rewords the comment Michael asked me to
add which is currently technically incorrect, but will be correct after the
separate bug mentioned above is fixed?

In other words respin this to make a v5 that changes the comment to:

  /* TPA is not supported at all, so there is nothing to
   * allocate.
   */

And then when a fixes for the above commit is proposed, the comment can be
re-expanded?

Can you let me know what I am missing here?
