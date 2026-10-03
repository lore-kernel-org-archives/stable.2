Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0E43F1077;
	Sat,  3 Oct 2026 12:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.242.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791030416; cv=none; b=mGGGyFfpknGB1Zgu0au9MN1SOGPTOjZyY4PKmGa8tEFlFm9dA7/S1Z4IlYIDBXBuiw3MVwT4U66mMdXGFNRrDCe82v58uDhLnIwQ8Hm3iLFMcxcbIKR7LHGEYOMsTJeJ01AbjgfveC/D8twOv+kIsae3foz97Q7GDy+2L0p2Kj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791030416; c=relaxed/simple;
	bh=M65+BE89RRmf9gTuhSx9lzPxHh2SAUBuvp6CWfUjIVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTygX8fFllNrHLgN9fk1NNZbtYH7HHqQuqHPkfuK8JDdnAexq2RRN8bdYgHfAw08oghc94p/nv7z/XrSNL2P2WryhRSwI54eEvM46/A3k9E+80rsUQEUPIWOXV3YqMdCx2vYKdOQeK7Qsd37TOBUmk5AqYrmy52BdgQAIDcDgr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net; spf=pass smtp.mailfrom=davidgow.net; arc=none smtp.client-ip=203.29.242.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidgow.net
Received: by sphereful.davidgow.net (Postfix, from userid 119)
	id 985772003C0; Sat,  3 Oct 2026 20:20:05 +0800 (AWST)
X-Spam-Level: 
Received: from [10.80.19.179] (unknown [103.137.210.79])
	by sphereful.davidgow.net (Postfix) with ESMTPSA id C0A25200395;
	Sat,  3 Oct 2026 20:19:55 +0800 (AWST)
Message-ID: <baac1e91-4dd1-401c-833c-3702a90ab974@davidgow.net>
Date: Sat, 3 Oct 2026 20:19:51 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] rust: bug: pass TAINT_WARN to warn_slowpath_fmt() on
 UML
To: FUJITA Tomonori <tomo@flapping.org>, ojeda@kernel.org
Cc: a.hindborg@kernel.org, acourbot@nvidia.com, aliceryhl@google.com,
 bjorn3_gh@protonmail.com, boqun@kernel.org, dakr@kernel.org,
 daniel.almeida@collabora.com, gary@garyguo.net, lossin@kernel.org,
 tamird@kernel.org, tmgross@umich.edu, work@onurozkan.dev,
 rust-for-linux@vger.kernel.org, richard@nod.at,
 anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
 linux-um@lists.infradead.org, FUJITA Tomonori <fujita.tomonori@gmail.com>,
 stable@vger.kernel.org
References: <20261001123103.2198104-1-tomo@flapping.org>
Content-Language: en-US
From: David Gow <david@davidgow.net>
In-Reply-To: <20261001123103.2198104-1-tomo@flapping.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 01/10/2026 à 20:31, FUJITA Tomonori a écrit :
> From: FUJITA Tomonori <fujita.tomonori@gmail.com>
> 
> On UML, `warn_flags!` calls `warn_slowpath_fmt()` directly. Its third
> argument is a taint number, but `warn_on!` passes its bug flags there.
> 
> As a result, `add_taint()` gets 2304 instead of 9 (`TAINT_WARN`). The
> warning is not recorded: `/proc/sys/kernel/tainted` stays 0 after
> `warn_on!` fires, where it should be 512. It also causes an
> out-of-bounds write in `add_taint()`.
> 
> Pass `TAINT_WARN` directly, as C does on UML.
> 
> Cc: stable@vger.kernel.org
> Fixes: dff64b072708 ("rust: Add warn_on macro")
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---

Nice catch!

Reviewed-by: David Gow <david@davidgow.net>

Cheers,
-- David

>   rust/kernel/bug.rs | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/bug.rs b/rust/kernel/bug.rs
> index 3566f0234ca4..af8eba4563de 100644
> --- a/rust/kernel/bug.rs
> +++ b/rust/kernel/bug.rs
> @@ -85,6 +85,7 @@ macro_rules! warn_flags {
>       ($file:expr, $flags:expr) => {
>           if false {
>               _ = $file;
> +            _ = $flags;
>           }
>   
>           // SAFETY: It is always safe to call `warn_slowpath_fmt()`
> @@ -93,7 +94,7 @@ macro_rules! warn_flags {
>               $crate::bindings::warn_slowpath_fmt(
>                   $crate::str::CStrExt::as_char_ptr($crate::c_str!(::core::file!())),
>                   line!() as $crate::ffi::c_int,
> -                $flags as $crate::ffi::c_uint,
> +                $crate::bindings::TAINT_WARN,
>                   ::core::ptr::null(),
>               );
>           }
> 
> base-commit: 551c722f40809618230001baccf219193e22fc5a

