Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793847937;
	b=vMnR5QUr5sOKwgO5exwuJyRw2NPUoUW09IeL/a57plpujWmDzCYFZz8h0m6kZnpIGnt5
	 kieiC0QbvUONo6K+7LM6Cd4ebq6OKdqmepDpKT8XJeLgEFo4/F7MmWDLTnRA1rxkZ9YBW
	 xLspTpBI8IhFU0jqXY3NgArehth51VHSf+dRDhaBsNieqzrOemlE6sINxXx+pE7us95xy
	 hVvwwVg4ZTnaXOwBe0Hew3DTz9DAA7NkmaPj3gOi4rPPF/RIbvyuaJsM35cItylTMLbn5
	 fKb9V6PgLLS1A1suhljkgcAh6pd6vE0GJHzkZAltYFcZLZ5Bd4zHz2adXjFkbuxz+ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793847937;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=9xIguVReA3V5SZUDkHgjtW9XgljexvCmfUk/SQdX/9s=;
	b=SdjdKxWR584itMq6YWx4UGKYZXCoeOUoQemD/nychJRc4oON8FoZpSj/rl+VpF5WVAU3
	 k/DmbFJc+GK7oaOzQnWAPF0dAcY9ERpNZDbIAzktajhAY/azKG26eLeUnuH1TDQUY684p
	 aKhO3A090clO7Ikgs6DQ4xdxRlWXoJYhxPeR4brHbTXl+b3pTXTzatF2N82RbofpPSMZB
	 N8/GFkGgzTfGThbo+tF3dQpTOg2sPTjIVYadMozRiF4QEPQTg29AcvhTfjm/k9bSWx3Ge
	 fqFkdBERdb0ZwkBba/pgeDM9EMWLPoxHFbx6RTlbh0Ya7nPYgccZAUYamQBu0OyXcog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TJFr0FE6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EBC606A326;
	Thu,  5 Nov 2026 03:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TJFr0FE6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B964C1F000C1;
	Thu,  5 Nov 2026 03:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793847936;
	bh=9xIguVReA3V5SZUDkHgjtW9XgljexvCmfUk/SQdX/9s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TJFr0FE6GnJWJ5BA0xO6Z3FyzL6gPcwj4k8TNcnAqmlM4Uz0m9z65L8m/XhVraBJJ
	 k/448veIdvaM8ZgwoR1e4beSn3SPs2iv7ETdVi2gXLNRaHrgrFtG7RETSCIUswwj7l
	 76opx8RrdwDKImp6o46Mpm9nEA72YSE3IkzSCglRtg4hwkZ9s6c+OCjC95xOZcY49d
	 OlyZ87wb7RC2iV/afC/SdvJmXSs8625FM4K0d/ORXB3onW7l0cowM2Qv7dFC8ozqMT
	 aWy3KkCrFkhc52a6IbMO7tYIDa9gVuPVPTznzzq2XnWrGTk657B79fk9Ec8C/cawJh
	 bGLA9jxuA4OHg==
Message-ID: <23ffd3e6-14be-430b-bc5f-aec46e13bb4a@kernel.org>
Date: Thu, 5 Nov 2026 12:05:34 +0900
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
Subject: Re: [PATCH] ata: ahci_dwc: reject invalid device tree port numbers
To: shao.mingyin@zte.com.cn, cassel@kernel.org, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261104221318841yKO89PGcSNeaV4KutBOUJ@zte.com.cn>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261104221318841yKO89PGcSNeaV4KutBOUJ@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 23:13, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> ahci_dwc_init_dmacr() reads the "reg" property of every available child
> node and uses it directly as a port number, both to compute the port
> MMIO base and as an index into dpriv->dmacr[], which has AHCI_MAX_PORTS
> entries.  ahci_platform_get_resources(), which runs earlier, checks the
> same property against hpriv->nports and skips invalid child nodes, but
> this second walk does not.
> 
> A device tree that describes one valid port and one port with a "reg"
> value above AHCI_MAX_PORTS therefore makes the driver write past
> dpriv->dmacr[] and access MMIO beyond the mapped region.  Apply the same
> check as the resource loop and skip invalid child nodes with a warning.
> 
> Fixes: 33629d35090f ("ata: ahci: Add DWC AHCI SATA controller support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

Looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
