Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602443;
	b=tULtrCQ1Eqr0MVeJFtZQxliPDfecL92giOwwFZn4TPjBnYtlRWKWnl7BPpHOn3hvh2T1
	 gksYsOMRclkKADWb0bRqqD3fDEN1fVLBDTE298fNnsVTuBKHi0nmTVo9JLFXINpdKqiI7
	 kaGXFVqm5TGM9o02xTOqwPlAs3B+JBq+db30vL4f7PtZTVkXMDgKRX1pVolZKJP3uOsSm
	 N1rS1lNDeE2893spHzgq7zvZyOrBU/BzuHJPtixf2C05hxKoVgIag/WzUqZxyr7iXVjAT
	 Nb6mMxVryeTUiRMiPrKrWtlJbKTWrdW6jfWBasstYGMYmDjmsBemqFLc159oZpzK8cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602443;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=e0R5eQQgTdpSlU+oUfRU2hbSIpRyLJ1/Cjf8UXH8R78=;
	b=hlfuyDyKjPG2aWSqn0OzBbbbnaV6KZivCy+vHRNyr6O1YOqspYW9Eo3cUx+RzywLKKb8
	 l13X2QySVG4SAM2/lMXQCucMuoSIuanBiMAECiZlJs+/coALSTOWbTHIidzcijmVGcjid
	 j4aVkT4PMNwEUogwbq5aKGRFeInD4x49IZms06nJ/f2d5kSmzXyKNzqHsa2lp6/oWfq7S
	 SKY4n8+0DjKWaxqma6aDDFA8t1jRjCTG8U2v+ZSv0wLG2KMzqT6XnL43WHvXZiPNDXrDD
	 5obcAkhExQtuNfR+EyV1J+SMDB89xOlWJOZuBq5wjD19s3SwZp4q59CRVkroTqwAdZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=F9h0RjGL;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB2E606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 17:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDB2E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=F9h0RjGL
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-53667180af3so9230601cf.2
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 10:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792602442; x=1793207242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e0R5eQQgTdpSlU+oUfRU2hbSIpRyLJ1/Cjf8UXH8R78=;
        b=F9h0RjGLS0HcXPP8Lzs70DqrmIbMaklOZic6JTfWxOKvcoT80HSKNpl88Y3z4SuFex
         K0sa3BpTUNKpl1nH387ihAHymr8rCGkE8591JkZxYJkVv5IPpGOa6V6pm7y5aHUnOlwS
         RzxzvOns3zn7OqUFZijDG3I4WyRyWlKE/VUG7FN+Qcg4gj7QJVVAx2CPJfP3sFcmHWsW
         BH/NRLuL3cNa6l9chmS+FjCv7BZ9HyxAa+SBaLfVyfbIjBLpUwReKVmvkXYgk5cof3ei
         Q1/wQMXNF++xOiXBYp3CVn4FKSvq5r//TZyig175cZxg64B61fmrRxj4cgi4jswVaO1Y
         3M/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792602442; x=1793207242;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e0R5eQQgTdpSlU+oUfRU2hbSIpRyLJ1/Cjf8UXH8R78=;
        b=zdBNrJjCRaNsKHxXvC9Z4PUvhC0l3Lgs5VqkqgxgvML0WetUegCakrGUUIAME44X0F
         mcmmUFyel5vI+mldHx9o3gVWA7eYPHgbpzimkTChQYEGhzOXSdF6A1kwTqpk4pNYKjCQ
         0/0uGam1NWKLJjkw7im1TW0sqcn/8nj9Ifj8TItmrdYU9gm3Oy/ZelTjEzHkBuce2Edx
         XR4ipduQzcPlinoNSQJly0m2xkD87Ye68EQBMffaLdjmnfS7219hLIYDLJsCS2HUijlI
         /hcKnNR1mkr5x68D2UvN1P8hzjzyLXbHVBwQOMGZDByy/+ayZlqMeXyAB9y3P4hFu1wy
         Z/ow==
X-Forwarded-Encrypted: i=1; AKwUvBz3p+TL3DwKxyVbx6VsOLWdNCeBjYpmc1vN7ZNuDq7FRixHASdyAt85aweAjVE9qlWmHnjNmtk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJP57w3CPaNMi2SgaVWqctllo4qhebCxWu+taCP5pWEjcPl+cT6
	rUoOGZKSZvfaUPNEFSdSOjDx7LWyAsYMm8eP+5xlhcYlZw+tKpvTwWPX9Yew/6Z+3g8=
X-Gm-Gg: AYBFou0Blv9INlDT3Kvpf+UPm4CtTtCiOljwaNsuc39OYM2Q27sXkiq1AfioNFovt+b
	tJAO/1Hp7kmJlYfpidfTRKKuiCoeg7dWPA6PZKNhi+UUJ50U2uioFjrrx30Ro71SqlQuSDE9BSa
	jBuSaYVUIMstIfJV47FaUBq8CrRZL8e9T76RNWTVHuZfysvGOxZm5ZErCE7wNflu0KvTOl2m4nj
	cIcUdPlVgdLbjSjVd+9QgW2kMQ0OwTFtgowNDpE5uEeqmsabW84QRNWiTkWdkO8wz1UkO19WuPz
	X9LyOQEcaEMJkA7WXyIPtZ0amlwBmG0dDOKVzeGitxto+gCDX+cw4aP2h1ky1LXGfa83goiHCTR
	26uENV04NSOg++mxpas8ykVUVrWlh90gTEREHJiaWcXNQeo+O4lhoGIEg5vYAyKw6vI9T9HmjbM
	YJFdKhhLjdhAJtvu2pd/49/KvLVMeQ+WlK/r1rr7Y9pImuMSU2DB9hqe1ZqiCOGiaXIErtqcEyC
	51W91bxwcvNzwKivSiCWJlEUsGxpV+9S/6TaZLiSuZUY07cIWys+Eu301odkjtTvqydnTjG2M4A
	/+6ltfG5mYzqzeEfhG3Pr4r9mcWpP/4652fxVQsOp1fRyZkTraxrR5Zd2BY=
X-Received: by 2002:a05:622a:e10b:10b0:536:43d6:2a94 with SMTP id d75a77b69052e-5369b813476mr30068181cf.34.1792602441721;
        Wed, 21 Oct 2026 10:07:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536ab7624c1sm4234501cf.19.2026.10.21.10.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:07:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xJZmZ-0000000E9s9-1fwu;
	Wed, 21 Oct 2026 14:07:19 -0300
Date: Wed, 21 Oct 2026 14:07:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>,
	Dave Jiang <dave.jiang@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
	Jonathan Cameron <jic23@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sami Tolvanen <samitolvanen@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] rust: fwctl: declare cfi_encoding for fwctl_rpc_scope
Message-ID: <20261021170719.GU14213@ziepe.ca>
References: <20261020-fwctl-cfi-encoding-v1-1-ebb30d1500df@google.com>
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
In-Reply-To: <20261020-fwctl-cfi-encoding-v1-1-ebb30d1500df@google.com>

On Tue, Oct 20, 2026 at 08:28:37AM +0000, Alice Ryhl wrote:
> Currently, VTable::fw_rpc_callback() takes scope as a u32, whereas C
> calls fwctl_ops::fw_rpc with enum fwctl_rpc_scope. With kCFI enabled,
> enum types are encoded distinctly from integers, causing every fw_rpc
> indirect call into a Rust fwctl driver to trip a CFI failure. Thus,
> generate fwctl_rpc_scope as a newtype with a cfi_encoding attribute and
> use it in fw_rpc_callback().
> 
> Cc: stable@vger.kernel.org
> Fixes: e052daab94ee ("rust: introduce abstractions for fwctl")
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/bindgen_parameters |  2 ++
>  rust/kernel/fwctl.rs    | 12 ++++++------
>  2 files changed, 8 insertions(+), 6 deletions(-)

Applied

Thanks,
Jason
