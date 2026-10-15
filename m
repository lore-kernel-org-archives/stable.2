Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E47243956
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 00:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792023606; cv=none; b=Gu5THfDIsl6PrecSTemP9ZTl4ZMhkg1S9UKXIYV8S20w9ycYl4icN1Zdk77bPrA0SIX4UcrXRnrnlrIMuOHySvrM4TIdNdDDYoGAayHZkH0QwKRQFTDe2A0kQ/SE2+6beFA0ZvKVHBaIRlfKz0jdPr7pUSWXmPsUd3P0ttH8sb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792023606; c=relaxed/simple;
	bh=AnNVEavxqtyOTLpLxYFj2+nZEID6bcl0Z2S7QWhHL6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRjTONuxryng+MieF18/sNv0EUEgpDVuR+bW24Tfpm038i/iVVBNv/i6hkadYB3nxY5rAxqfQbUg33fsGsuIBpJ6HWXCCsjgs9wxrV7BF/AhXsz6gqvJhe1wqPT87HTkhUfi5TlCq7qVb0Y3fEciJJJRXbpDHj+NGEgFyJ7vG3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rijFxrjr; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rijFxrjr"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd5e6f0a22bso793456a12.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 17:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792023605; x=1792628405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ISbHRDvpK26efrlSANt4b/Vey+sE4YbMfz0mAYLwgdI=;
        b=rijFxrjrOwq/WCKEzLWGTcoWKMPy01wXTkwsNGGD2jZMbPFknXuJOqWtVtnTnbW2p4
         hko/hUFuUEl7OTLSub4ZwfwnWHO6eJLdp3NTXdSXrmIQvJGuOyixo8mw5/ocS+tV4R1U
         /V2lZdjf/jFF3dAekF95KtRGOdwrBdyL22zp4mvLFNMtQVwcFXy0ryXOZtIxrzMUiiMR
         7u1Wv34oQ9MmiHJyf7r7VmXFCeFBGlS/pOJsDSkyb6yDow0SffXoUvDtfGSYT6+1S9LA
         DSHIS3M3/cwJfE9+Wx+mhd//9muV68Xs5tJotIl7srp3mK20C/2kD9+TNLM/P0KphJeQ
         trSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792023605; x=1792628405;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ISbHRDvpK26efrlSANt4b/Vey+sE4YbMfz0mAYLwgdI=;
        b=ha177ZepCT7g1ZcOGFdfgKHSBlGVPlQcY0+VJCreY5RX++4eF9SdUIDY8vT6xHjoJ0
         Nv1Q/4ToqRjXYvy2RGsSLC/bO45AZ3sPCWiVwiw4NaH1NCCYJEVR8DTRB887S+iQk/4F
         8YF35UfpBvvdSCM9I5LHBVLl5mllF0Cn6bxrMZmfMZHS3zlcfJn1QoD/+Mg99AJSIjuH
         k0LgWxMCueC+cR7NTHsLW7pIOoeF1M/R0U79RNBh0nH3m3pfzSO5Qb9a1DhqVktOZRoT
         uxKJsO5rRS9lMRuJt+78TbeWBBBJaXqKHdFutsm2xNFMusyREA7rYhjFkCXHp7L/i/g4
         8r+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwr/7haLUrpr0ZSORTvbwXxxuFYJbTvA3ZDdwlu38k6Yt1HOG3iFi+GBTCrU22qDx2xnGLOnZA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQjE9m/aVuk1xuVZjsgVBn8ycn9RQclneF4ohbVDderjYpmp05
	Px0MdEOlcdksjkZROuoNLiOe9QRBT57B0sFaDV52TH43cx+0ac1TekAMywN4NT+N
X-Gm-Gg: AYBFou1i3DLmUADjOQCi+hcI2jm+SCEJx7RSqNNG6WHe5DtNJOTJbfJ17UOCeymSpPd
	QWSj3iliNVHpe6ty9PpLb3XTXh75x857GN41azxd0G3aoDUBCT/NY4NwzwOeklql6dPMYQYBSMK
	Ny2xzk4qq5YNPhDAdYBRrXcWIFpajfaA172EwFt6KW8hX5kserruhbcCDzA43zhcX5p8nV1eczt
	AMjv2uF/QUirOV8nTlI4efiPhsFOf3FjJpB/QV8PG/S1cfcWzsiv1t5vuvHKXsREFXM459m7CyL
	WMSBK0xxfCI+fRw6oZDyT+dnpcNY+QzHPZloFGb3ngtjEWCOfRhkHV6peOg81ZKy/jBPBlSSHbL
	M7LxJsD7Fcj1fEkIE5fQ3JLVeNvpvU9pJgRs3FwIVG7H3mrplNQUvXG3HQzWSlhYxNWwHe6UaAa
	MsyrG/PuMWTTroc/6TPIGCGeb1JaV8G42YrDJVyMJHgUYHLJVAx3DqKKs0OFv3
X-Received: by 2002:a17:90b:2681:b0:3ab:189b:6981 with SMTP id 98e67ed59e1d1-3ab3a92f9f3mr13983908a91.48.1792023604661;
        Wed, 14 Oct 2026 17:20:04 -0700 (PDT)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac93ff4474sm1597813a91.0.2026.10.14.17.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 17:20:03 -0700 (PDT)
Date: Thu, 15 Oct 2026 09:20:01 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: linkinjeon@kernel.org, ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org, zhongling0719@126.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v5] ntfs: roll back the ACL xattr commit when the WSL
 mode update fails
Message-ID: <atAcMSHpAbf0aTGP@hyunchul-PC02>
References: <20261013015652.19724-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261013015652.19724-1-zenghongling@kylinos.cn>

On Tue, Oct 13, 2026 at 09:56:52AM +0800, Hongling Zeng wrote:
> ntfs_set_acl_ex() commits the ACL xattr before it rewrites the WSL
> mode EA, and removes it again when the rewrite fails.  That only
> undoes a set that created the xattr: when the update replaced or
> removed an existing one, the old ACL is discarded along with the
> failed update.  No error is recorded when the undo fails, so the
> new, typically more permissive, ACL is left on disk while i_mode,
> the mode EA and the cached ACL keep the old values.  After a
> remount, a chmod 0640 -> 0777 that reported failure leaves the file
> accessible to the relaxed ACL while stat() still reports 0640.
> 
> Save the previous xattr before committing the update, and restore it
> when the mode EA rewrite fails.  A removed xattr is created again,
> since XATTR_REPLACE fails with -ENODATA once the removal dropped the
> entry.  Remove the new xattr only when there was no previous one, and
> skip the undo when the commit changed nothing.  A failed rollback is
> recorded: NVolSetErrors(), which the next persistence point persists
> as VOLUME_IS_DIRTY, and a log message the errors= policy acts on.
> The flag cannot be written to disk here directly: the target inode's
> mrec_lock is held and the $Volume mrec_lock cannot be nested under
> it.
> 
> Fixes: fc053f05ca28 ("ntfs: add reparse and ea operations")
> Cc: stable@vger.kernel.org
> Suggested-by: Hyunchul Lee <hyc.lee@gmail.com>
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

-- 
Thanks,
Hyunchul
