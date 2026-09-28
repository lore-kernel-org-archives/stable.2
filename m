Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC514E0202;
	Mon, 28 Sep 2026 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610819; cv=none; b=lYoy9QckTt3iNGPye1/gP4cnDbAzyEWaVSOHrcP6A+1kCb8+Rpk6tqNkyWT4s5CFnnAn23+zszmtTrp+pRDoVRVNk8f9N2VO6XyiklVlXcsFnemKGHCsVZaRozpNkvlgH0SjNk7MKX/ACOVVJR2wg5SeL90DulmMk/K3vz0tuxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610819; c=relaxed/simple;
	bh=5Pte3CGEjRbyjHTBkhIucqGuWbmoRF61U/4BFXA/Ptg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=NVFmDA+gaTRSqv/leiBEDWEHl3CsX9cHdAAFfOhGqCmJYvnIA9fb5Nm2az4d2X+zLXlN2aSTlkoXL3SrzYPCO1ojhbjWzdnKgUrLtbUNKrI3/iNFFQ/3ghr3x0VjFYIf0lD0z9vu2KBLvKWXJAj98skAD0kz11LGBC3BlsKBGhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=MHbLePBr; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="MHbLePBr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=X88DybAWqtDrvlqs74paXSRb0jFPiyP7iB8vHzmO4aM=; b=MHbLePBrJoqjeBmUy/0A6ZSSRj
	BR8XVRjFjrUqDVtLBI8JBws4yap9o8D72hA/vmBCasJDprVZsm1T9zTgKAIwTHxScnPuTkbkOe5FC
	HtI0459yyeJZ/kdSDbBZMdSLUPoJJDrcxpGO0gEeJAY78ybRnbk+msGIl8NhH+dn0/uXhP/qeaSpK
	OjFBJxhuDl1/DY+UcfFR1q4c3tXkxaaDYPjj5hsTOf3ZPe58tI+oVaZvz3ggFKHDlwL64xh5ZYeXZ
	bQyqJnV+vHwlVktUca66ECgyM1404imCzR24ChSLFAoLlz+kIPvfay9a0NE5VNkBfiDSo5RckjrwW
	EOhRlJ3Q==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1xBDfb-00000002TUp-0cz9;
	Mon, 28 Sep 2026 09:53:35 -0600
Message-ID: <eb81f218-7470-46f6-9762-cbd5058406f4@deltatee.com>
Date: Mon, 28 Sep 2026 09:53:30 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
 Frank Li <Frank.Li@kernel.org>
Cc: fuyuanli <fuyuanli0722@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicholas Bellinger <nab@linux-iscsi.org>,
 Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260928152550.3354675-1-den@valinux.co.jp>
 <20260928152550.3354675-4-den@valinux.co.jp>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260928152550.3354675-4-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: den@valinux.co.jp, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, Frank.Li@kernel.org, fuyuanli0722@gmail.com, gregkh@linuxfoundation.org, nab@linux-iscsi.org, joey.zhang@microchip.com, ntb@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v3 03/15] NTB: ntb_transport: Make link setup flags atomic
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-09-28 09:25, Koichiro Den wrote:
> Convert nt->link_is_up and qp->client_ready to atomic_t and use atomic
> accessors throughout. This prepares for the unlocked cleanup check and
> the link-up ordering fixes that follow.
> 
> Leave control flow and locking unchanged.
> 
> Cc: stable@vger.kernel.org
> Suggested-by: Frank Li <Frank.Li@kernel.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
