Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6252913B7A3
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 00:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782518456; cv=none; b=pMKXI3OCopnCxiXWInW0tYzTa2t81Mxvi0N1HVUlNH4GGL+pmX/GItgujZCjDoey+Rub1Jba/61FUPBNkMXdWEbh4VRLnZsxgkHYGb57WW5tDTqYAO4O5rtc44KGuAcAFR3CesahfZNUbLw4r1kAd1TnnNu7G/VeSK8Fj7JztPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782518456; c=relaxed/simple;
	bh=tGIQHoq4qK5Eb4FAZpd/KMB8JhWc6zGurunEeF1Sxg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQnR8e9EFXO+0A+WKlKipy5a0Ygn2I7AikUOwMe8Rox90S+r4nLZHj98Jsqf3K2eenOM+2ahg4g1mmcEBWhsW1iw18vPkx5M3NE8PPK8RzR6Fr4zdO0g9BFdpJU4fO+uadR6BbFO+muVY2fF07/KNY4Mg0/Yb4rDTRoRh2HEqS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l5damnCH; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l5damnCH"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c81db32393so21925ad.0
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 17:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782518453; x=1783123253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QqDPPLJzwuxTB89us7bsdVJAmyNxYkv4BpfCzxYJck0=;
        b=l5damnCH21c52U4xUKOm6SbLFVDsXUmSrT0CBS9sAHcDHYexifr8aH7AXLtNV9mDXT
         u47nuU0LlCSlBLh38P2xXdOi3xwxAtm4hpwVoMq+ERCsOJxLSpcAOgIbAU74i7IDgQKC
         MHN5NlIUTS2t1lh5AWDvj9YtSzNCrNhHNbTqf1WtjNn5AQmHx9GOll9Dm+wvcfapkQJc
         E6IN4lBAUWIJfckcMo/bZ/hBk2E+vsc/FN0xbnbLNZdkYWWfDTj2nSnHzIcNMb5vExeR
         qF7UVXk/EiA9Et+Ac7kxHyi+V945x7IEi4kCqpwhRdXFp+R7ohDlxTldUAtpA0gUjVli
         NJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782518453; x=1783123253;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QqDPPLJzwuxTB89us7bsdVJAmyNxYkv4BpfCzxYJck0=;
        b=IMzMpea1ie+lh1Fb0FL9eZCp0uLcjmNYV7FZKQwufBBB1COo+lTHJ1170CDxE6N8eh
         M5+3So1TNvPEDUpMZV774S4sFKGNd+y/D6j93KKFlPtsVhFiNOh623DrP3YYwwOJkm7U
         cejjIJzKoYzCobUiFzv3nryfMwWnvU6mz/U9azIEfwlbuzGazFubPO3CZROQHAhVGBkc
         5dDUToc1L9yBBuNFVVyt9ReytQXRGi3XfJONfJ1RAqrpEUpwpRxUGxS2g9p1pkyELKsE
         5MDT81yovLCs7GcoSyJotkJAfuJHDEOZcWJTIl516OL1ivfmZYtUmBDo5sOGERChFKv/
         uTIg==
X-Forwarded-Encrypted: i=1; AHgh+RpLiWohaFp5moT1EI5cteBuaOMt8jx4VoLrquOaBUixVyJs6/54zmGW6hkC/mbaZVuTNP6fqts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8cA8COQRvbEuV2Ib3Wv5KoMTuk7G09cSZlqnrjPpJvOU5RRS6
	mkPl9OITDiLFZjE7iU1SfsWvO/46CPDg0MIfRPur57r1iYOgTZ7El54nUIhgdL9WHw==
X-Gm-Gg: AfdE7cmaA7ZmQfdwlPdvtMSsq7fCBqkjmsEBDejba+WRLPPfmoREhT5pYzn7yr3xN8p
	TtaGeLn/tb7RWDo7oJl1ZZH3RNJz8YQPsyJkiKghnVDxIfkMDghG2sH4FFJhQSxX2pxv59MSkqQ
	Iz18XpxFY27ReR7jggwtLpUFfAvisKmPntCAIoXY1D/5oAXB5Xa34Z6xylBDZc6jNXhcmYtqRIC
	D80GBUozpebgBlekw2PCy0/HJ3cC1tgralNz62qvFy7YB82eD6dcRtKmnIpYi/1PSl/bHS9KkKc
	pJ1x0G7cUMAqPX9feGKc9rBrbEfCtaIHkD4r1Yh7M5/spt63wYmgmMJ7OwXjlkiAbQp1xsqfD4b
	SmIH06X/yD7PDXqHFnUZqW5oD1acFmbCPkE/HFFc/YNtQFH0Ii5lg2ZcMGEGcWbdeMw9IGAeyMo
	Be08rUiNJ0pkk7VGlBa0s472Oh6mBhl7e2j2vx7NsNLAD7kuhU0Ou53y2n0uHhUXAdY+wgR/up0
	29sJ3hW6pHKeQ7at2bWXNueRuMYG5qSyVM=
X-Received: by 2002:a17:902:f612:b0:2c7:9e6a:1a8d with SMTP id d9443c01a7336-2c9a24512fcmr1139135ad.12.1782518452128;
        Fri, 26 Jun 2026 17:00:52 -0700 (PDT)
Received: from google.com (112.174.16.34.bc.googleusercontent.com. [34.16.174.112])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c81aa46aeasm20037615ad.17.2026.06.26.17.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 17:00:51 -0700 (PDT)
Date: Sat, 27 Jun 2026 00:00:46 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Hyunwoo Kim <imv4bel@gmail.com>, aliceryhl@google.com
Cc: gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
	brauner@kernel.org, aliceryhl@google.com, mo@sdhn.cc,
	wedsonaf@gmail.com, Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] rust_binder: use a u64 stride when cleaning up the
 offsets array
Message-ID: <aj8Srto26mBb3vQ6@google.com>
References: <ahw3tFhLz9bMMJAO@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahw3tFhLz9bMMJAO@v4bel>

On Sun, May 31, 2026 at 10:29:24PM +0900, Hyunwoo Kim wrote:
> Allocation's Drop walks the offsets array (binder_size_t = u64 entries),
> cleaning up the objects, but it used usize instead of u64 for both the
> stride and the per-entry read.
> 
> On 64-bit kernels (usize == u64) this is harmless, but on 32-bit kernels
> it walks the 8-byte entries in 4-byte steps, iterating an N-entry array
> 2N times, and reads the always-zero high word as offset 0, cleaning up
> the object at offset 0 N extra times. As a result the referenced node or
> handle ends up with a lower reference count than it actually has (a
> refcount over-decrement), and binder's reference accounting is corrupted;
> for example, the owner can be notified of a strong reference release
> (BR_RELEASE) even though references still remain.
> 
> Change the stride to u64, and read each entry as a u64, narrowing it to
> usize with try_into().
> 
> On 32-bit ARM, when this over-decrement would drive a count below zero,
> the driver's existing refcount guard refuses it and fires:
> 
>   rust_binder: Failure: refcount underflow!
> 
> Cc: stable@vger.kernel.org
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
> Changes in v2:
> - reformat to satisfy rustfmt, as pointed out by the kernel test robot
> - v1: https://lore.kernel.org/all/ahjpn-3WQTywTdyj@v4bel/
> ---
>  drivers/android/binder/allocation.rs | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/android/binder/allocation.rs b/drivers/android/binder/allocation.rs
> index b7b05e72970a..ea5846e4da16 100644
> --- a/drivers/android/binder/allocation.rs
> +++ b/drivers/android/binder/allocation.rs
> @@ -259,7 +259,7 @@ fn drop(&mut self) {
>  
>              if let Some(offsets) = info.offsets.clone() {
>                  let view = AllocationView::new(self, offsets.start);
> -                for i in offsets.step_by(size_of::<usize>()) {
> +                for i in offsets.step_by(size_of::<u64>()) {
>                      if view.cleanup_object(i).is_err() {
>                          pr_warn!("Error cleaning up object at offset {}\n", i)
>                      }
> @@ -420,7 +420,8 @@ pub(crate) fn transfer_binder_object(
>      }
>  
>      fn cleanup_object(&self, index_offset: usize) -> Result {
> -        let offset = self.alloc.read(index_offset)?;
> +        let offset = self.alloc.read::<u64>(index_offset)?;
> +        let offset: usize = offset.try_into().map_err(|_| EINVAL)?;
>          let header = self.read::<BinderObjectHeader>(offset)?;
>          match header.type_ {
>              BINDER_TYPE_WEAK_BINDER | BINDER_TYPE_BINDER => {
> -- 
> 2.43.0
> 

Hey Alice, have you seen this? This looks correct to me so,

Acked-by: Carlos Llamas <cmllamas@google.com>
