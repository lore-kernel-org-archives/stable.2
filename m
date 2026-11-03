Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793699807;
	b=K+nUVKWK8/dzMqfw2CxWumPa4IUe0c+AJmpFHzl1XGmNKKdb/7pTP7fX4H6KQ8+GIzBp
	 /IwkVmgZ4ICJc4uNmkS/zrYV8WAwpbBVODwZiTZRa2QJ8OsWjg8hROIP8SQfxGgP8HVzl
	 BR3k+Um/yo6ndzDOvOBbVfVyU6iepANePV6r7EcYQ1x85W4Z7a6SzKIRMO9IfzitO+KPC
	 B+e++n5Dyfu5w+RWXZInbooWtP5iSll/SA2ZgeJAKqmQ6UaO1H6uupbVPw6NJI1iu6MXI
	 fk7ez3WiI4PxrrT/2beL/d7I6WS3YN2F/r135aaE0J67XDAPSUTzN8GQZs39wJHKUWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=iqwD6eaHeERb7Ot7SCnGyIPnO7ssTxQvxGidKCgiKP8=;
	b=zATljWT9C8E5OkN2/F0eBM8tIkORsHYINwKe+tZLu8MN+F88PxJo0Rl5AcM5jqcaBGw9
	 7jYL1R+Tpc6zFs6GwWcruL++XKXSyyPkC+Ll35tA/x74NpdEK9HXhV5Eu1fOPgizMp9Xa
	 OOtyR0KZiY8HqNdTsXMl3AUiRd16TI7vtIcOONgbfuCaIdvAh9Gylz5zF6SDcKjMY6uVk
	 ATmMMkf/AZRwP7nuscvqaHdGKSMjhdILctW15L5r9rHXBgjA25q7a4i20tw+RBLX9gTaz
	 DueffBGwaS2XL/H9lnxO+FnD10/SjnCWrSOONv+QptHew8pp/9yBtnml2aRVhig57tQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flashbots.net;
	spf=pass smtp.mailfrom=flashbots.net;
	dkim=pass header.d=flashbots.net header.i=@flashbots.net header.a=rsa-sha256 header.s=google header.b=S2+DZbZG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AB160A2621
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 09:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6AB160A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flashbots.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flashbots.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=flashbots.net header.i=@flashbots.net header.a=rsa-sha256 header.s=google header.b=S2+DZbZG
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-84a248254f4so2722290a34.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 01:56:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793699806; cv=none;
        d=google.com; s=arc-20260327;
        b=OeLqsLV4sl6eMWch0Y+E7cq4kwcxQsn9m41pihM6PYohnN3Pk6hTPMnF4XfwboYrBG
         IVSe3BojFbzapii2T0Xx1uz0JXbgaOYrWGcN8FiVrn2JDDPbviUVgulSOMD6Lx9h8Wjs
         EWWXF8wnWoYxQQW5dRtjr0SQQIfVQKk/aKtaR4ugoQNKKP1LWXPJm4nskUfcLvEGkSXg
         tdfXwU+5wGT1jjELtocd/O9/RiQ6Qfq7w37IRDRClriMkE12TPh0M43Wnie035RH0ZBM
         eC0MpeVX5V7K8YT2nRsK5wOewfamTLpZfDsARDbkcg6t6pT7XMu2ehxFltlyE8ebTRie
         4GcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iqwD6eaHeERb7Ot7SCnGyIPnO7ssTxQvxGidKCgiKP8=;
        fh=JjSeAK1lx188t+wxGal/dYtSRVAKPOuW99zaG57tITc=;
        b=bWfHv/9IxwvCxmc9hLrqvwa4Fao1EEX+q2dhoBYdhK19/EgP13FSOgz5pGkcdQOYxC
         bjYsxdtFDITMfdy/1Ej/0mMiWwsaq2BkHG1fitIm1+YxbUuvZyFyVWi6tGibQxCfCA6/
         RupnJNzsekJbvCig6bS/gII0qdxdAcK+OoFxB5QA1dWn0KAyesKPiU+4AV0YAR3PEDOW
         Xz10Y/xhljvf5dVIWp7rXIoZNHzAr7qn/15Jd3xm8fE1U7MlGAvJsTPVI0kL151BWuAa
         XK+tpm5Z+hzclLrvUl+VvvfzdJqdQmj3ZWkz7cOSZCOZxjheTDRlEdKylLAtUMK1XZ15
         PhZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flashbots.net; s=google; t=1793699806; x=1794304606; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iqwD6eaHeERb7Ot7SCnGyIPnO7ssTxQvxGidKCgiKP8=;
        b=S2+DZbZGfkGYEUmOM4H6oUoDwS149KfIEKV9z2GMh3SdJF1ippnDz9fJUMrELY+kyB
         LlweaK1g0h5miifipylhvsV5b5/c5N7UCaWG91bNx3gpSwIzMlcACIf6ueuZIKx7e3tH
         M2OMexqbCPpTzN0KJt54O4mXO7XNVmdWtH2vNvG9OIcUpDvFd2hrRODF78IpSrNArOZd
         bSHFrVIM/QCOX4kCnFTHqVj3qh3R2iCdZk8nwnv1EOlbXHASU8S6sv73a9+ucLz3quc8
         JMRD6KEkaPW/e+C3LXJ0zrPHbq5+EjYx3Rhl291JfJyoLFEPkQf5weN/WDQkDd/SyC0Y
         vLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793699806; x=1794304606;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iqwD6eaHeERb7Ot7SCnGyIPnO7ssTxQvxGidKCgiKP8=;
        b=ww2sGBYjGGQdEvWJ2foTm5UGCi6qogE0RbtDmMEWwo/70wSocTxQMGy0gCOspqJbAn
         g2a2DIW5mf8mmVrV7Fsn2IGpC0sqDaQunBsdyHMoDF6TU/YRT9ZU/GbGCT7Hdi2MCKq6
         N7rNb/cMFTZLQhWlfR3GoUyoeVyAFb7PKZRiN7H5hl/d2n+PAmbblVPM8SfkySo6bkss
         raRdv9m6BWAtOekosqAx95duCEZeBwHFzPD7qnsKcv8bySKZsk9NqG9Rv1dW81/EDkPX
         CvrRjbQKmOM3H8TSG4QU63OSnOfBmDNNyhUV9dCPavcUyEq0QIm9p71ZeJeXmDZPHjQI
         ydsA==
X-Forwarded-Encrypted: i=1; AKwUvBy06RRiXTHM4CoGIoaWg/BTZgXnBAk/YXiWNxwPESi2ufb0jrGxga1zWSqFb+kCeIP/sczMrqQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/lOJJ8kbYS9ZMjQJZGufMhXzCTB5DprRITKjjyLhWtslYCAsEu
	vYnQKeyBQ4rxGk1CLAQhHnj51r6vASXjTAtG5hEPaUk0pdRTbJUmxllCOBE6CHjGNdk2B3O3tIF
	soBeQK15CLAnBqt9z5QJFOpxYrIFaSnymxILDJXIXMA==
X-Gm-Gg: AYBFou2mlz7TEesiNdI5DW5nlCgOgCkexn5yC10sLvmcEKe0kL6eFFo7uuRjLDEoWc8
	fG2MiC0IgVuFCLH7UV2n1qI3pSowZPtxuuv7klXOuNfSyR6AJ6w0k8nhdCo3itVWCAbDpH03rqQ
	CR/vc9IVQdgpA4xkyVkGeTdC+ZueS+V9kGfTh01ysVTVcsslsVQp5L0C8vXbu6XOx6S6RE9AKjt
	5AXDzgesarP41CVEhTvjkJ1t5cSZ8na6bEuEL7fzZqIVi228VFSjiTyCncVy++y5pqCkEI0+rKf
	8mp2mzNqAxAxPVnQAwJ0iVTBWQb3gnDmjlh16zxYTxQPRJ+/a+1a04tkJpwbYcNKNcG90SNNrii
	7EpsrKl7OeQm8wIMRyZ3a0fVfITaFyHXoVavNId7FHR2eT4QqG/zPk48NN8FEtz56QLNCPyCH7G
	+DvFdR3Jx2NkDKSy9KfqhsByBmPD5EjEjxjMBr
X-Received: by 2002:a05:6830:4c05:b0:844:4959:e855 with SMTP id
 46e09a7af769-85d3636d94emr9384433a34.6.1793699805932; Tue, 03 Nov 2026
 01:56:45 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024-tdx-guest-quote-poll-v3-0-6a83bb767314@flashbots.net> <3b582cdcfe37f1d01ee71611ab2611f845261089.camel@intel.com>
In-Reply-To: <3b582cdcfe37f1d01ee71611ab2611f845261089.camel@intel.com>
From: Moe Mahhouk <moe@flashbots.net>
Date: Tue, 3 Nov 2026 09:56:35 +0000
X-Gm-Features: AclHuK8Doz0oEKFnQPO1b0h9OeAQOCO7SR7lLXwryMRNxDi7qBGsHP1Qzst1PTE
Message-ID: <CAKV3HMM9BKpmgWeFqRqamAsqqiofj+TG4DrOEHmbUyE0FjA7+w@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5B=F0=9F=9A=A8ext=5D_Re=3A_=5BPATCH_v3_0=2F2=5D_virt=3A_tdx=2Dguest=3A_Fi?=
	=?UTF-8?Q?x_and_speed_up_the_wait_for_a_Quote?=
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"kas@kernel.org" <kas@kernel.org>, "Aktas, Erdem" <erdemaktas@google.com>, 
	"djbw@kernel.org" <djbw@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Miao, Jun" <jun.miao@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2026-11-02 at 19:55 +0000, Edgecombe, Rick P wrote:
> Long term though, isn't this a better option? This patch is
> essentially a performance optimization.

Agreed that interrupt-driven completion is the better end state where the
VMM supports it. But I don't think it can replace polling.
SetupEventNotifyInterrupt is optional in the GHCI and enumerated through
GetTdVmCallInfo. KVM only forwards it to userspace (since v6.16), and a
VMM that doesn't implement it returns SUBFUNC_UNSUPPORTED. So the guest
still needs a polling fallback for older KVM/QEMU and for other VMMs.
Patch 2 is about that fallback.

> Polling is always going to be weird. And when the attestation speed
> changes (possible in the many upcoming attestation plans) this tuning
> could again be suboptimal.

The fixed one-second interval is the tuning that ages badly. It puts a
one-second floor on each Quote and, with quote_lock, caps a TD at about
one Quote per second. The backoff assumes no speed: a fast Quote is
seen within a tick or two, and a slow one at most 100 ms after it
completes, with at most ten wakeups per second.

Polling was originally chosen (f4738f56d1dc) because Quote generation
was "not time-critical or frequently used". That no longer holds for
users that bind a fresh Quote to every connection, such as attested TLS.

I'm happy to work on event-notify support as a follow-up: use it when
GetTdVmCallInfo reports it, and keep the backoff as the fallback. Would
you take patch 1 now (a standalone fix, Cc: stable) and patch 2 as the
fallback improvement? Or would you rather see patch 2 together with the
event-notify series?
