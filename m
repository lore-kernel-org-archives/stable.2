Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794984620;
	b=3DvlqkA0MIl5n3LrAXUSRzSoW4hV6nAermFXeU8zgA2pW/gb0heKLEeKX3vfJBqAbfkg
	 AMcTJJFIzBh3zT9DlnPblMDpadoRTlAd8FrVt4DHVZo1kx3bAW96sLuPnvKYJvTwkZVM8
	 FLDSY59CZ4I5BhQB7ba30gQYzMsgN+0698noq+TffOIwsLxjDehG84bspXg11BE6ugD0s
	 xPMaNnznMyjSK88NZr/7J5hfJ3ISDmL7xNjPMKJE5O71gDqZVzsBZGR4HoWBg9Z1IHP+3
	 bP23eDBe/A6O6FD4a2CkOE6BdP//DnOeUEwpoPSt7YWhI70x9gWVMafqHfnSKtMC6uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794984620;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=U8jV7OnHEFz0j+0ag5AfooSr+IDZRuR+qja3G5heTVk=;
	b=uOsS99uUNfwCzh9BXeDOuoGkPBXvjBohQ1hW802ocITkfcDJma70ntP6UfmIE33r+x33
	 ZCvWMzqV//FhVHLVlCL76i+BufZrMgJVelnmwlFj2J+XJy1ZQXvp4s0KzniruM4vGf7ud
	 vxk1iD6BLb3zSuC7MZN53r74CydP0YrOs1BenoTWa7TfF9C7/Xoc5Ku6Ek0FbqjlQTGtO
	 baliE+K2eEhtzrBLs9xE/cV9fju+BKU0YcD5t208SIN/yZMr+cHptPbjpFfj2Ns5hVmNP
	 WAnyibbZZ+2/z/Vyd+Wr+586txhQDh8l79tG750+zBIVLvVlf/t5kfllbWLhUPWrZNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s0uXzD84;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809A2606A325
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 06:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 809A2606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s0uXzD84
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ed408b0d9dso2819495ad.2
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 22:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794984620; x=1795589420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U8jV7OnHEFz0j+0ag5AfooSr+IDZRuR+qja3G5heTVk=;
        b=s0uXzD84SDYX/NyRfUu+pmyAx3omQcq/Npa12/ohehJ37cs5tojh1o1ewVq72p+t6O
         2ANwHvn3nZk/qCYXz+8aAB2FH9S3QPhqMog0+dT0kw4pOXg2G4UekNHEoVeYR7HLYWq5
         8/7l9qh1/kg2m3BmGP/zIZh1bIr198lrZRgAvzORwYbzlzXiCdkhHVpnY8o5+Oj5O3j5
         QCvwpKBRNpKYGu9ucjJjfmZqIB/R5KccPX6rIMNVF7CNmb37v6OU1g8/oxh9DFiD2BK1
         V0ZqfK2pr9GKZ4+gXnPH876yIB7FOGlU7q/Ohynk3hTGvUXGTPbs2w8AO6Ux+DweHVYi
         yhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794984620; x=1795589420;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U8jV7OnHEFz0j+0ag5AfooSr+IDZRuR+qja3G5heTVk=;
        b=EmZEJGFelIaREQyFWdq581nyr8aYFzHEJDZG/+9lYkh3rL9tv3UfCQa//ijjS8V1Lv
         pZW+Agy7wuYTADKrvZKXGkaxS5sTYNoeWcNfXFBd78srUP2j4iyiyLm5LcoZPmMEzHLW
         Yw74/mcxsChK21WNiUjolB7yIJuJEemGyXECGTm/6bgDxeP+n46eMmE9HUNbImbuxUoT
         Qqr5ACwwTmPfSKV4qH3XLWwpRdEUR7oUVsFd11PnSNHPJeVAzCDpEctUthGNOebAsAZE
         BWqLPsvbSj42SEkpYN/OxNQeU03TDfQh0qGK3zVDJyfDCBMNgrC7fmN65/pQgiRr0W5T
         +cqA==
X-Forwarded-Encrypted: i=1; AL+hErH7FXCi7MiD/dWhPFiiCgLow4heznlqq/nIcjdiq3onYnSYkKfW7nEPF5O3WhMM8PCse0Qvw7Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z82kmNMiOz8JLiCfLCD3psXYpVnro1+VGi82z7vz2nI2w2z983h
	jRcIdHYsSOaL6HptXyLihIADV6Ghi+M+nO9vb9a5y+lLXQYtEkP7978y
X-Gm-Gg: AZFdTZdUW6Ep8GXXoS8WJvd68JGtp/5qck6UAan0XxIsWAdjZUOiWlYXNG7ZC0m+KZm
	sT6NkhCHUDjbqV9k2BckJp/zs4eE8YQhRJmue+ufzvJiCws3v9d4NZDOZcbmBBpZoIIdEUehMkM
	MQ5VPn4uWVIXc3gk8L6UwYZp5Eo3fRHq/B17nyFxz5IHyo4Z0Q86laVppm9U4/shdDm2FS6yKGp
	qZg6oGadx4StApmT4cJaBzwazwvBUHpXDfUTmyWbdhoz0MPIOjduzDRzitIDjVthWSSvNJyGTnv
	kqCbhgYjveFWBdwV40RhUiG8zWxQHa3dkVUFgXYhKIpqbHRZDsZ4AiqTc2llQBZ0TT0XQuOQJyZ
	2T22lUhthT/D3T8VXe7rW34kbf2Jyxaw2/SRT9bq/zBj+paNke2N/HoJ6i40qZ5v63L4qryW77p
	jM8E5WXTMrJ78YFqcwK+9n28fA4nNBzawOUuBV0GG878u3WZATH548ZTUPefuVfdFtgrp3Ilvvh
	a+XNxAB2olHU2CilFZC6bMi0AkFL5n691k+AQR8ERhkkAakwwMlnG2lId+GGPi1cuwcbejOfItE
	VYR7wAEUxhipEX4prZX2Ckq5wMH59Rd1VlOn0oVFCoPlyRPXpEe8HkAi0dWW31xpFYVc/cysMl3
	mHqOYDLocgPnWGM7e8Ts=
X-Received: by 2002:a17:902:cf10:b0:2ed:e22b:77a2 with SMTP id d9443c01a7336-2eff7560dd4mr16662645ad.55.1794984619740;
        Tue, 17 Nov 2026 22:50:19 -0800 (PST)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff62897d0sm7773615ad.64.2026.11.17.22.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 22:50:19 -0800 (PST)
Date: Wed, 18 Nov 2026 12:20:12 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	chzigotzky@xenosoft.de, mpe@ellerman.id.au, npiggin@gmail.com, 
	christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, msuchanek@suse.de, 
	ritesh.list@gmail.com, harshpb@linux.ibm.com, gautam@linux.ibm.com, 
	amachhiw@linux.ibm.com, venkat88@linux.ibm.com, nnmlinux@linux.ibm.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH v5 1/3] PPC32: Fix hard_irq_disable to follow tracing and
 lockdep state
Message-ID: <av1KYTtbzgwtDKn_@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20261118051419.783878-1-sshegde@linux.ibm.com>
 <20261118051419.783878-2-sshegde@linux.ibm.com>
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
In-Reply-To: <20261118051419.783878-2-sshegde@linux.ibm.com>

On Wed, Nov 18, 2026 at 10:44:17AM +0530, Shrikanth Hegde wrote:
> On PPC32, the code for hard_irq_disable has diverged and it doesn't
> do lockdep/tracing anymore, leading to use of both local_irq_disable
> and hard_irq_disable on PPC32 to overcome those.
> 
> That is un-necessary, instead simply calling local_irq_disable is
> enough. It disables EE bit and does lockdep tracking.
> 
> Subsequent patch uses this API in KVM code to avoid the warnings.
> Wider use of it is possible, but it will be taken subsequently.
> 
> Cc: <stable@vger.kernel.org> # v7.2+
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
> PS: New warnings would have started since commit 
> 12013e3d4695 ("KVM: powerpc: Use generic xfer to guest work function")
> which added local_irq_disable for 32 bit. The proper fix may date back
> years ago. To avoid backport complications, keeping it backported till
> 7.2. So removed fixes tag and cc'ed stable.
> 
> Also, 32 bit shouldn't need hard_irq_disable. But that can only be taken
> up subsequently.
> 
> Also, below fix isn't needed anymore.
> https://lore.kernel.org/linuxppc-dev/a14571be1897955f43d9994f0e093de3ada6ecde.1793447880.git.ritesh.list@gmail.com/
> 
>  arch/powerpc/include/asm/hw_irq.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> index b7eee6385ae5..ddb850e62abd 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -464,7 +464,7 @@ static inline bool arch_irqs_disabled(void)
>  	return arch_irqs_disabled_flags(arch_local_save_flags());
>  }
>  
> -#define hard_irq_disable()		arch_local_irq_disable()
> +#define hard_irq_disable()		local_irq_disable()
>  
>  static inline bool regs_irqs_disabled(struct pt_regs *regs)
>  {
> -- 
> 2.54.0
> 
Cool, this makes things simple.


Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
