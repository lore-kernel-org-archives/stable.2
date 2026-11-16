Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794861759;
	b=vQLZkfE/lgKEJRxEPquTGLDfeuT3KBg2Co6DXRof0seSMw0h/3DGvD3aEzY4AxO6MNku
	 9He++EwrvOBQHn0IYgHcyRMeQAZjPQwF/CgUgdr1AJnVeEsQ4EpWO212R/7jAJM66f4Dj
	 lCa7wPxbLaARXhrFQzuyhhYvd+T9NRbTVZpNJYp4E/dBfu5Un6mfim4RfTfhSduBShlo3
	 /vjrffkSWsR28Bf/q4c2nTBcPxokAzJhKJeeNgGevl8L2M9gd8TptVAdeaQghNjoFPn1M
	 LuuRYnOTv3/mIfrlOFcqhKreoLtd1vKldzdFemt3+Y74fUZh/XISNJyNMUiQ1jS1Wqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794861759;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=A+DIt5xU6Vu0VGIqtgySpbQoKnMSPgo+owOoPySLOEU=;
	b=N4zWu983qv1QOFng/0Quw6Dn7ezEH/D3DHnmIY+z8YB8b+nSGV//ibP0cNoJ9ZQYH+r/
	 hBSqesdGqXrbuETVxA5Qap9OWjpdJ4Q8IbqvgpuM2/Dk637nr52xk02FXdHTmu9drlspD
	 GGHnFrjWOaOHgKa5Esz6GnIteg0H7RU+cd856fpUnxxwMU/qXTUXeorErMEA+Yn9jZWVW
	 tH7FtjrkfrKdIQGWKQQfImq/DV1idX5FR8fuVcAFHqqzJ1SO7s5jeK5gDgc5VtPTB7WZs
	 G6o6+OkQA8G27UEC2xX7Gib8Chtp0eII4vwFpDj7bukG0jwVfRYt/rw6IIOT8vdIAPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BpT5X5yG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC858606A322;
	Mon, 16 Nov 2026 20:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BpT5X5yG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3671F000CB;
	Mon, 16 Nov 2026 20:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794861758;
	bh=A+DIt5xU6Vu0VGIqtgySpbQoKnMSPgo+owOoPySLOEU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BpT5X5yGM48z9Sya/uX3eMmXkqz8dPfxel0GmlaNK39ypxTPS5Fyva3laguDWp46e
	 EsVTyccoJXZJl5zKwVxGQRMh5gL0IctIkiG3QlQ5qfPIeiefRTzbqsZDZ03efFbPmI
	 t9tGYpL5F2hWNcxlROjTjwekUqbvSCf2WUGEh347dGLj9/lk7gnc9PVKG+8vRZ7OeJ
	 QubYd7hGDJT/Y4EdZgofq57DnaAlcKdrdXUpVWAX7S74jwBn8pSScCdDOajqL0KYZz
	 bnAADxU8LgGhxrMKt+d6x6G6/o/rLrTjrtW29LeTrVuJQil4he5mnofdCWImFNySqR
	 oVvfHs4HzMjnw==
Message-ID: <ed90f523-62c6-4066-b67d-76d5de4c7544@kernel.org>
Date: Mon, 16 Nov 2026 12:42:38 -0800
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
Subject: Re: [PATCH] ata: libata-scsi: fix the INC_512 bit test for SECURITY
 PROTOCOL IN/OUT
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, stable@vger.kernel.org
References: <20261116191008.2954277-2-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261116191008.2954277-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/26 11:10, Niklas Cassel wrote:
> ata_scsi_security_inout_xlat() tests the INC_512 bit with cdb[4] & 7.
> INC_512 is bit 7 of byte 4 of the SECURITY PROTOCOL IN and SECURITY
> PROTOCOL OUT CDBs (SPC-6, tables 280 and 282), and bits 6:0 of that
> byte are reserved.
> 
> Test bit 7 instead.
> 
> Fixes: 818831c8b22f ("libata: implement SECURITY PROTOCOL IN/OUT")
> Cc: stable@vger.kernel.org
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
