Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274237;
	b=csNmR/mMm7J7CyxF7qfsOfVNM1aAwRtVeU9z0qMtzcMOAybxM1otGXOTVJlk/2xz+2mr
	 mnxtuVhymbvCUKkZAWyySlHCLRzMYZqAX+Dq7wyZ6mc+vAGgGn+/TbGGBt7ACStwK4RxB
	 AkLesNJdnEpg/SrAIaLv1H/zdDsCGghlUsiid285QKvPiiLql4q3UvvaSx5v8RJbg5Z4C
	 Us4bbUlDb2h7hUSgxHDWped56NafdAPrL5MUh7ioalkqzem1395fwX+zuPN55zbhsgAYf
	 ijEFLkoRw/m/ket12WyqNcpaZpz2cfGZYL4vh+drvZArDIzDsYobJ3L5JjF95ls2NyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=6cr9ziobUF9AnItm9jr9xGM9l0DDOZ1SgmvFxuND5DU=;
	b=TRWcsP0nbhFCW+ZusDcl+l1UCqosSE+P+TSE1dTIGkFBV+aX5c/H2PnJzYWaijyhUDoN
	 hgs+SObfOInOxYLOfkr8gxWeKTmn3mF/m3wFRNw7F7ZtUzLdGP3taAHdwfmjwyohSVAX/
	 wxOoBjiJGNVHKaFn8Cz3HMOoac76Ny4DLAVyrINz6lAR9skf2W//vCwB+ML/cTEkUn0PB
	 llqJhpxbqAd9ELZmn8YW6S7L3dU6qICKv6WMgeS1M+T2WwVk0ZNzQonh8Vv/VZft8avuO
	 A7TWQ02opUugMjtmriKZImQn0eOlGFZMmWpLk/Y4NSsgSkxNeoTBH7BVTqUmOIGe1/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=pardini.net;
	spf=pass smtp.mailfrom=pardini.net;
	dkim=pass header.d=pardini.net header.i=@pardini.net header.a=rsa-sha256 header.s=google header.b="FQ/Vg4eZ";
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD72D606A339
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD72D606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pardini.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pardini.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pardini.net header.i=@pardini.net header.a=rsa-sha256 header.s=google header.b=FQ/Vg4eZ
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4cac7a7d3cso213416766b.3
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 17:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pardini.net; s=google; t=1794274235; x=1794879035; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6cr9ziobUF9AnItm9jr9xGM9l0DDOZ1SgmvFxuND5DU=;
        b=FQ/Vg4eZ2DaEJ51myVQiaugzwi+/CrgpUMLwAX7xlzIUdTYY3BVr+V6rV9VBg8iaHw
         vNvrtIgzLaaY+rcERUMZPEEyWcFk636tB6X9T4nWTyvUQaQoTZAEqdYZwdBHeAb0qxG7
         6VevPOLmI2lWHIPG7jemP9LIimpTffXxrMzMKf5xf3cTlJAGIOu3OQ7ccPu3uH0nlY/r
         W7nWaLSZWCaNCDG2fHPCAls/LjfBF1VfL8d04G//ZWrYid+Adt5qbkwIaLo9O6QBASnV
         gomYcv8rr3oHeI4QNvDY63+Jv65H73gXjIiKuQMzkT9uwoa/9impg6RTkAIjNJxhA7rs
         99ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794274235; x=1794879035;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6cr9ziobUF9AnItm9jr9xGM9l0DDOZ1SgmvFxuND5DU=;
        b=UzJreo25Cmzb+v/M4ewBOWYK7Gm1sxLR/1UwXA1r/9OUulkFxZFNTAjGN+TWlsMyzC
         Sowz+2PRobBMq7Db1R6hFHgs9siYocjjO45tswhdDxls6zL8PtNDcsGfAuyt60qCYWW1
         ynXnpqZjywelb059AiuhxuHUzwYlnmc8HTvHYq4orTFYtqDtsPDTTRVkV0aPhP4BrX5F
         AZoBNiyebC6hBZSCfNwNovtHds4XK6bkzlk19TexfXx+SpoFm9sZB4LovnE95oTGYwat
         3MwNlr/m4Z3NWv/QvnLNrkI+9X9cQIfduJJemXW5bGNKiIUocx5Yds9fsDrFRf056TNb
         0/+w==
X-Forwarded-Encrypted: i=1; AL+hErGdN8wlhCJqvA8g9bISZW1NYe1iWViXIlNDgJd2Wm5NOTvIFEvbvcT2WOUtvB1subK2rv6eWn4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1zvgZh15nS/jGi5gvd31d5vv0XUl6iLx9QlOVNeFgBA5nqh9v
	jbuv/F1NXSBxkWSirlQLSaYaWeScyVXLu7g9hFlTnW3eN4OFobCIYrqiioPC6svTvw==
X-Gm-Gg: AYBFou3YE9KezfS2+kici0V/nnfuM2BaeUOEHC0BhabckfCKd6pYV6HejCrouzNLxGV
	fEmfLFM25qXuShlmDK9mZ32qHSckLFlSEzl0zW5kvwHn7tp83mqNlKgI18O9icPITcq3axv9U2U
	mE35Ij7mDtV/E+ewyRBpKvLphk3uuPkPng7OwVQuQ2JshceTdDMmE4QZIC5a6CZR8RYJzSXEmmo
	E4LMhSXep+/3Dn9fMPHG7HfVtW3qSOAEdWX0LDAwwk55ibSkJt+uaA0q0nYTbiLQBjFscJRuihQ
	9dxOHcUxe8qRmCS9TueYCDuG51fdO2bMErBtMGnNhDS4v/s3oPkTgnSB5P+UynjmXXpjWH22jkt
	bXNS6j814+1cmoz0QXeAK7fv35B4RyjBh1F2PufuC/YzJ8zDnvqVi4fT4ABkOeh9HoAnkoVoCAP
	pVZNclNjNPLxFYsFR9lPPw3Bp3CK5svAQ2KwJIstnPgORTJ0dkmlTbHFqcJmsf5kswr63/w7a9B
	hvfn77Z94grc5Es8gAzFiNUiX8fJV2QuuHUX2oLnNnm4vYOQ6JMgYFWL6lUz8XbjaJBdqyIFHzr
	mJ8lywlbQwfT7mc+zcoa+ZVItAy9yeKVefChP8xeRckhYwLtT4sLSDZyCJe+aprYDOvSA4TAeMu
	XdGet1InZ/EFLwCsvmGvHWU3/raOipFRCrSm+O/dwaJyxLzRaH512eaR0VBfThhMyjbPuFQ==
X-Received: by 2002:a17:906:c108:b0:c40:d920:747c with SMTP id a640c23a62f3a-c5048f4046fmr83137966b.7.1794274235103;
        Mon, 09 Nov 2026 17:30:35 -0800 (PST)
Received: from ?IPV6:2a02:a466:4d7a:0:65ed:a8e1:a329:4b? (2a02-a466-4d7a-0-65ed-a8e1-a329-4b.fixed6.kpn.net. [2a02:a466:4d7a:0:65ed:a8e1:a329:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a5701a1sm41990066b.21.2026.11.09.17.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 17:30:34 -0800 (PST)
Message-ID: <f225b5f6-13eb-40d0-a9ca-7efab0e6876c@pardini.net>
Date: Tue, 10 Nov 2026 02:30:33 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: rockchip: naneng-combphy: fix RK3588 SATA pipe_con1
 register offset
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Andrew Powers-Holmes <aholmes@omnom.net>,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Yifeng Zhao <yifeng.zhao@rock-chips.com>
References: <20261109-rk3588-combphy-sata2-6g-v1-1-e9135c91de6a@pardini.net>
 <avJULe_00cHwMh4X@venus>
Content-Language: en-US
From: Ricardo Pardini <ricardo@pardini.net>
In-Reply-To: <avJULe_00cHwMh4X@venus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sebastian,

On 10/11/2026 00:29, Sebastian Reichel wrote:
> The patch is 1:1 from Yifeng Zhao with a better commit message.
> You should keep him as the patch author with his Signed-off-by
> followed by your Signed-off-by. Feel free to also add my R-b tag.

Thanks a lot for the review and for the directions. I've prepared v2
along those lines: Yifeng Zhao as the author with his Signed-off-by,
the BSP sentence (and Link:) dropped, the pcie3x2 link reset grant note 
moved into the commit message, the notes below the fold trimmed, and 
your R-b added.

I'll wait a bit before sending v2, in case anyone else wants to chime
in; Sashiko seems happy about v1.

T-b's from folks with a &sata2 board (Firefly ITX-3588J / Firefly 
ROC-RK3588-RT, from a quick search) would be nice too; the board I found 
it on (Mixtile Blade3) is not yet sent upstream (I'm still fighting its 
2x FUSB302 and PD powering troubles there).

Thanks again,
Ricardo

