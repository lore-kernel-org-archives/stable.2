Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6A446DFF8
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787056006; cv=pass; b=A95KuWSOZZTskt8evhJsC8N6zTcWHTTZ76aJplazls5E6o38zfNhhcXQnkD8rH6BjnpCJUK81yxRIUyMg/NfUnMu/IoqInI+Nh3R58GjQSeFZVE3IQOPMVF4550wjgVvzA8bwqwpQhbw2B2fM438KezL2lADdf6umA7Cd7WgLgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787056006; c=relaxed/simple;
	bh=kLjG4blPBMdpWzPmKacj4BuVzm/7SEdFKQgIAE8kGpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Puq7U4wr0bPGuZcQJ/hqF7uCDlmuWpS3FiaWuoQZGo4we272UjIL/aibz1kd9B+IvKEsBtbVkwmGv7tvTHAlDojawXRMCHRJqs/fb8W5CY5qWWPkKFUflh3q9hgUrpt9w2SX6gvwiD2vVlt/5sxfWuQB3xV12rTin8CTwfndEV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=hAO6Yveg; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="hAO6Yveg"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-52b3934af3fso45150951cf.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 05:26:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787055999; cv=none;
        d=google.com; s=arc-20260327;
        b=FJPOHTLDZG4fAzLSd9NHyEKr3a+ukoQZA2bAshbHuma9E0fcEwy9JDnA1X1BI1RiEz
         t88abiGkqE9rut2pwTDuJXSKz3oC4GSlr1aj7kcaUPeXWpLcWMAHXyTYrQX2QOc0ExEr
         +/I+trlDBRZhyHb59fjZb1IKShryUlbODfK7BKE14VDHczytyHPvUgXo5aFhgoZTtwkc
         /gvs/MbMXUaENAxA8jO5s0Zc+52xArV7gUluXO7QHelqFi9pQZXeiIR1RCXaFNLz59ce
         2aHpHQXBAM819DMC4hvGD2j09qaJF1MYMxxqcxIAHxe9DXOquL20JsmJY0tjr+j5xkkq
         vkDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kLjG4blPBMdpWzPmKacj4BuVzm/7SEdFKQgIAE8kGpU=;
        fh=dliHt4nAaRT2aXsmsQ75edYPb7R6ZkVurzq3cWqP8/4=;
        b=f8mEV0MW+6smMNElOG3OFu0ZvB1bDYGvgdriptexKuellUt/8h4OTi5xtxrd5q5kWa
         eRQsfVq/oVMnhx4gUPH/Ruo0dEwMnu8dOOtuXccihVuCi2OlY3FgjMM52d59AmpzCW8C
         aNoJre44Z5e4QUr+6ccGCOwE12GdmCLRlt33dN6P7koAfQ6MmCPS6yse659aZH2DoSZV
         MjIdNJIX6w0zvkXyH6C20mqBlVG/m0FjFEWYyYQC/KdAV45BwKwQ+ro+VlGteLPE1FE2
         thp0Ay/1W1NRAG6+El87H04cfbVkTy445QgO/nLDe+qTMijJAsuAsxJC/XuhzXqgSuzH
         4+CA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787055999; x=1787660799; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kLjG4blPBMdpWzPmKacj4BuVzm/7SEdFKQgIAE8kGpU=;
        b=hAO6Yvegps5JeYzrpC9uPHPEH2Ywo3nBGbtX3pin+bfKYDrOdMtPv0TEpa5FTNDZFT
         P/VF1xaXHE3XWqyIf7MnO1UmVBWkikmN8MELOC950gL71aVtxTRN5i9yMchFMo7i6Lhg
         6pl0lxK32wFElvLmOmu0YEJhduBkI/yfOkiWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787055999; x=1787660799;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kLjG4blPBMdpWzPmKacj4BuVzm/7SEdFKQgIAE8kGpU=;
        b=FuGqbIPwf7TatnSNZft+dZ8yfUZt56YZywcxjKckVKAw1ddTXp86Vu/TjGZycgAx/F
         t5CM/SAu/DEyUdAMRBGyci4ZdRBFeIfS765dupA7LrV7Rms+5WkOqeyQ0ICQAmUel5lP
         eFZFfGSH3hwEsb5vi2uoNiTP/iS6ORE4adEcyYZBiosL3FLhVV9o2E0ZrZTB4ZOoV72J
         ecWAq2x2wF3GJOsRRurYGq0kclIOnIEJpikLCwtSp0159t4wrNQPF8fA6MawOVUeC9df
         NgkeCxKRUbc94ZOtZpUbiKzBvw1uCoERgYMmeVYkEzYXmSH5ipVEFzfrywT9ZNBMBfYY
         GZaQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrdg21ZuT2dC4Da0Ke1hGgmjT4/eHbjvi7l6tRHfrZkZ/dIywjbc74jF2mFlx98yRf2d62allo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Ec1HS/yE9Q6BHfr/A7h7jTG34ZQWbYkumipUKN+GzLoAqjxW
	43DI1X2+sa1zA7cGdtR7NTTykAjL0oDG8XRBvi3V0Dlwo49TQiqT9YseYWwOyBPFdtSjjMXylIg
	2me+ykTHXkZm0ebcF4Y0VguXZsMbR5eCVP94QjWtz6g==
X-Gm-Gg: AR+sD11/8Cnoukfq3bhl7EQ0/VqBXgW9fQ4e+HrGOC2DVkBGJECBdgmtxtrY4f5F9Ea
	st19FxXTi3F1LsJbQWQUTIC+6xawjFpw+rLbc7Spf9MA96zVHpa/oNUNT3TdxfDtkVCdTgmNlXW
	/GiZEUXxBC8Jojf1rpFLV5XdRBb25RHBUV0KvOpQq+UwS2tQA81TMWvhbAwxl8h/2D7KvpkL3OY
	DSF/lXWlEnVSLYiSFd1uPuM3ltISc46dhYv7GTTa0t0tH5KzhCh4l4oYw33khN5aCr9rs6L7eFY
	x0IFs8UUEza/hjnOLEO4a+jmdNbO8CSIbXnnPh2D6mJZgd3VU6XOvpmXIgB+YqYBI4Uyd63cOY3
	M
X-Received: by 2002:ac8:5949:0:b0:51c:fc4:a144 with SMTP id
 d75a77b69052e-52d8530ddcfmr335928241cf.4.1787055999194; Tue, 18 Aug 2026
 05:26:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727233706.218446-1-xmei5@asu.edu>
In-Reply-To: <20260727233706.218446-1-xmei5@asu.edu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 18 Aug 2026 14:26:26 +0200
X-Gm-Features: AcwNN1X3TurRVqh3drsMqsffCnxzux841IzZnvq7PDJVAO37SPootEXFLrLLa-g
Message-ID: <CAJfpegv_cfPAiS29SBR9Jb0BdcGT6ZqP0ajN4nEKF_Dbz6ifiQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] fuse: copy request headers via a stack buffer for io-uring
To: Xiang Mei <xmei5@asu.edu>
Cc: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bernd@bsbernd.com>, 
	Baokun Li <libaokun@linux.alibaba.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Luis Henriques <luis@igalia.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Jul 2026 at 01:37, Xiang Mei <xmei5@asu.edu> wrote:

> Bounce both headers through an on-stack copy so the usercopy touches
> stack memory, not the slab object.

Applied, thanks.

Miklos
