Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263895;
	b=QLgBT9OhRZMn+s+Dtva+dwIuLjzx7fA0uJzyM571cQIecVIqX+hcfVvlrt0f6BgdDhvx
	 //dl+QlBby3Qyn3GxHLzuQJa7NyI0y2uaA5e/PAOh8WXXHPVnKPCldQTu8iBSChOkcZ8w
	 qjaH9baGlSSrpnOY7imMEo2ylf5qy7iWnY70plxtYEPq2ruvSPPL5VudtOTAeqNKKiCRh
	 EB6BsoIv4uESS3inYtbeZW3PfQOXGGqlTpnqllt7xSGYo7k9nklHuGzxiOv1wMPjh2kTW
	 5p8SKj6drukcwmVR2BmAbQ8QOpIatyfMLbdOSOMMc+Qk+eJkYqCVr9LQ2Ru2ZgppKZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263895;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=uWoSKvG13Bf1DgxAL14kWttvPonvgvUBLko84wLjNeA=;
	b=T5QB+pbhjc8vrDU37gOpGYhNBP4GyD+yvBcjIObYtB2S1ntOy5+5KqJAXX1PlmxoUEPs
	 pzaVa0FhKN5PZhyKHSeS8LO4asrKdjrPMgn7MRDv2k81Wynz3gzQMmP3WtCOjQtAm5gxR
	 uZ077WiZSKQIt/saQYyctFbWeCFUWDirnAWnRKcv7h3+EAP3tgi372oVZnFJRSR4Rvohf
	 39bzyWNrTFhYYWfMOzQfhVUVXBQhBw/LgxapTh7IBqaHAaXU0rNOAoPIa1ZpdYGdnmZaA
	 xZ8JOXpL+YGjyt6o4LGS760yCQHny8sm/tQmggUYc/EqYt7h9Wxm1DfAPu/HdDO/Wvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Hz418sqQ;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E63B606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 22:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E63B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Hz418sqQ
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ed3f563739so7815ad.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 14:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794263895; x=1794868695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uWoSKvG13Bf1DgxAL14kWttvPonvgvUBLko84wLjNeA=;
        b=Hz418sqQ5WLxOrswSzcH6/jjg8l4emN3gYOn1t5FpTvrYHQAQXwv32GRZWcofR6eT5
         nSJjtLSpe6bd8Z02Vh30sinBXoxoMuKNwGZWCOvpqYcKcx/9JLLxL+MhMYRxTy6jvAW6
         b5geHLwXjwwGM9qBHv+hiBBwpB5Ww52NuVTmbQeFZI1HCmLN9K93b+x6n7dn05ly97iG
         wj9fgRNQkuqMe0XiImGwjjub+dpa7g6whhOikrLUNUF2N2sSGxbtV5PIjXNsbT+pTbDA
         wmdM0hER3yQSIO3x3upeVSpuL7380iNwQEoAK54RIW8ngEW7aJrhKvXfL/JyF5uLidZ4
         w+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263895; x=1794868695;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uWoSKvG13Bf1DgxAL14kWttvPonvgvUBLko84wLjNeA=;
        b=GSmvZKYG0EzNwDfB5N7YZdgnryA0Vu/NG9LVneXbliARIvTxhdmUivgOp8U48RgJlw
         5L4P0Lzq2gNJpKQnIbY/6vJ5kVkNtlH9Q+ikuwbJhHpcr0AEqmbzgShaDaYHSYeGrQNt
         sJYhPP9ysscRuP1VEI52FAWiBh7JYvP+H8pOypoxxB/ESruwTo3rVsfxhZHtPcPzNvBp
         V+VBFImd74t6iVrAyrP1kT5m+4997nQ/RZUM6t6qTQ2/OXysCciItSZGrD5apxLumxBY
         gbCKAkIcE+tOVe8GCUjdBi058we/Umt7oMPoqcPBph/PcDiCsbx/88pgSb/RBNS4kSkT
         m7TQ==
X-Forwarded-Encrypted: i=1; AL+hErGIk1DKhbYwh7xV3C/143vzen8hUiiOaqRiX3JNyaZaUH2/73J2aQiy7baOtWxJwh85s3RvtPQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Bk2eQ5IxeFIEIX3oUQWZFdqOlM6dOWVtC+hV07KMaTM2W2io9
	ThMOoZ5Db0rdbi9/aH02imMmFGSijKSr7euTdwbSEl9gRcOnocN9WhuWA1vp7nsHMA==
X-Gm-Gg: AYBFou3hSQTTZVGKIUGG76qkhw/ia/Emty4n1yn/NVYJ89TSG/3Eap7KqMCvZ5EZ2JS
	itDTxvRV5bDNM94GA8kanSfHu2t7Dn/IyESnUzx8mS5ZZYrK91M765uFbR24kpmO3sxmTaJDV8k
	q/z+Ueith7EelslBf19HvoZler2mxvTq5rB0/+52irzas0gIHLytn5sMCYOTgKMgdH3+ixv0aRU
	hOBXft/QDcFPaSt6hNp8WLAzL0auFyGrQNulmVRL+fF3VmW/Q9dZFlohj5Ak8DzkIxTUDperzsl
	2Om9JxSlYkB3uUIncRZexQ4fwEyMmgDXPzGyE/NLo3I1xxMESC/SeCoB+ODHUNvhG1UUpQ6Y7JZ
	UZWPl1fTWEFFvTf7UDRPHBFEepYyUiOwhRVga9Wv1xY+8lSCezuso8phWP9uWSQG28HmKPJWdP4
	V8dUdWKTQJi91m/54nJWneFuw20Z+8D8N/o8i8sZoFj9v4vWAax+4ySaIKD6tn9ly4jd9k6bkxv
	dffco70h6Grf4QRaAeddwWZElwX4dKvIPzMAr5WWC7/G5IUTMnSyRiShLWG1cg588anjK2Dgle6
	zUyk7xcQxzeZbNHtGcxA8sXQZxCip8xxu30xa3fTAoLMeY/5TFRIBCKPv6iH9Oy3uXeZKMExSdo
	bhNoEMhZc5PfNrctm3/yMe9CyHm+WT5J+uPOz9RUB9gmM4XXbIgLHu8xgD+zpg7lhaqw1CyEA+1
	o6w2uv6OSYMxTvJr/mtN04QVS81OIzaczTgXStYJsfj3wwTWOiQsk9wM1Us5LMkbfn
X-Received: by 2002:a17:903:22ce:b0:2e6:344:7bb4 with SMTP id d9443c01a7336-2edba3c0276mr716915ad.11.1794263894152;
        Mon, 09 Nov 2026 14:38:14 -0800 (PST)
Received: from google.com (25.229.125.34.bc.googleusercontent.com. [34.125.229.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b16797069bsm1108885a91.14.2026.11.09.14.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 14:38:13 -0800 (PST)
Date: Mon, 9 Nov 2026 22:38:09 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] rust_binder: push BR_TRANSACTION_COMPLETE before
 BR_FAILED_REPLY
Message-ID: <avJLUdbdxhhUDL7K@google.com>
References: <20261028-binder-reply-fail-v1-1-8b71d4daaf1d@google.com>
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
In-Reply-To: <20261028-binder-reply-fail-v1-1-8b71d4daaf1d@google.com>

On Wed, Oct 28, 2026 at 09:46:45AM +0000, Alice Ryhl wrote:
> When building a reply fails in Thread::reply_inner(), BR_FAILED_REPLY is
> delivered to the caller before BR_TRANSACTION_COMPLETE is pushed to the
> replying thread's work list.
> 
> In a nested transaction, the caller can wake up upon receiving
> BR_FAILED_REPLY and send an outer reply to the replying thread before
> BR_TRANSACTION_COMPLETE is queued. This causes the outer BR_REPLY to
> arrive ahead of BR_TRANSACTION_COMPLETE, which is not legal. This leads
> to userspace tripping on an assertion.
> 
> Thus, push BR_TRANSACTION_COMPLETE in Thread::reply_inner() before
> delivering BR_FAILED_REPLY to the caller.
> 
> As a nice side effect, this lets us remove the now-unused
> BR_TRANSACTION_COMPLETE error path in Thread::transaction().
> 
> Cc: stable@vger.kernel.org
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

Sorry for the late reply, LGTM!

Acked-by: Carlos Llamas <cmllamas@google.com>
