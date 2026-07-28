Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06E738E129
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785257240; cv=pass; b=DqHgcF3g/BZeU/1EXiKcNjjaAcsDezldFwSzU8iLfTsB03rNqOdvxPRh9jgk2Uy7bcuVO6aMBuA3qTpdz52r/Oi37QnQvG56Dc1y0se55VFVGimWZi6DodkTl54cqmqIYwPwYEYRZlNT5ALdurf0WdDmCBB/Xd/YYvrFT7QCLUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785257240; c=relaxed/simple;
	bh=IQ7McHwnkjtHvjJGZg6FgEd5No0rIMg0ZdepA8jWumU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EJEnJr+NxKwFD0iQBA7CiZUfVUaBugmQ+llY/SQrklg/imCU+vZzmCse3NRMmKDmubij3j7dGli9hXxE5sSt4MNm/LHnvi4MWqnLg3XgUGQ15AXK4kaeYNyXci70H9IdU2ZTLFJGwamOavKebpoIpkuHJstzbNqhdWtnLSr5t24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=lka53NTh; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=F9Ewj46g; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="lka53NTh";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="F9Ewj46g"
ARC-Seal: i=1; a=rsa-sha256; t=1785257231; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rNWUQhD3CrP36WbEiQcPa2whUIA/aKSIO/BDx6TiIpx9cKFsz7Fjx68RmJGlH8jPAC
    nizE6g94O1WDF5/Pztb48efAXL8PT8GTjwohqcgZEwtWItCmWhKE3NRllyKiGsv8a9j/
    Mrh0bHJeOV72QvrjDofmCod2SddlhkQTxtE2WH0yYMIzj/d6X7Cd1AZgQmY9y+b9BGGW
    WyB3IsQD/WtlpxBBx2YXvGSX4YLA9IVJ/MgHqLhX3GS+/GwBVjPo8QyCs8YwdRdFXPCc
    bqRiz1FkR0NkOAz+h305/z104idxeOwoP1COY+EfD/VoYMwa80zTEN1G6OYGq1BX8VuI
    ZHuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1785257231;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=vUahJaVqQgENkYV1SmfUyaDmtRB/Xkvx1bHmd1S0pWQ=;
    b=NhGN0huf3uSLPhyUYhaiVzIjXTvze5EYtHu9PIuLFoZnhvuv0u3D8sZ9SRkzvIeaRS
    fiLnSIat+UwWJ0XtpqDl7BcxWf8Ho08TL35Yi3P51M+wFcgXiBRjnhAJnUy402qpI4WI
    e2dz8kRrftnARRHDMVYTWTIEuqrvSKLCZDxj1KqhejlqIVA4Asb1V5BzbUXdsVvbs5ya
    1/5aBVhFaQmSf2emFQnqGj4oYdbQBbjPfneXryP5kXlX+bvM3XlMuKiOCnmtQ5bKKGM2
    0HAdc+iLd1GjIGLsYojR0Rw12G2/Sn12P+OPX6+oTDlTeLHreUMeP9AC2RJR0cIxy63R
    WLXg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1785257231;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=vUahJaVqQgENkYV1SmfUyaDmtRB/Xkvx1bHmd1S0pWQ=;
    b=lka53NThF1CVI5heLSmr5rzB71z6ZNqi79CNqIH3zosg1+bs+OjEpGbZfjEdDWBuAD
    S5O7RSMtW6agnFxXVIr0F/7dAZT6AMDJod/Y1nzdmwLrKqYjTNhn1IDpeSJkWbu9mmMA
    X0XNe+JPIRe4zEpJ1qAXHoua0Omq5o1NVAn6hjp1bVxTK1LZttYiHJURqzXiIaN+ERK3
    OQ6+UZN9NMyOCF8AIJLtmVB3GDE30B+Erfcj7LJy1slg5dXbvWpqK3RlNEi+kHCR/2nY
    6RI3ncehpBiI9yJ24riKeUEx6r4xDGs37cYC+P7oFJeYSPN9NTWXN8nwrgnChav7hqxZ
    U9Cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1785257231;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=vUahJaVqQgENkYV1SmfUyaDmtRB/Xkvx1bHmd1S0pWQ=;
    b=F9Ewj46gQGeWQ/pXr9SBdofug53edtrctS0FWxkVCrLAoWar1anzTM9h1Iq2GBNxU+
    ocgJtyLTXJP/9K8OdkBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.231]
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926SGlBNJz
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 28 Jul 2026 18:47:11 +0200 (CEST)
Message-ID: <2da439df-783f-4fe6-a865-aa03ccc28571@hartkopp.net>
Date: Tue, 28 Jul 2026 18:47:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15.y 1/9] can: bcm: defer rx_op deallocation to
 workqueue to fix thrtimer UAF
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
References: <20260724102149.16440-1-socketcan@hartkopp.net>
 <20260728155654.stable-0003@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260728155654.stable-0003@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28.07.26 18:09, Sasha Levin wrote:
>> -		sprintf(bo->procname, "%lu", sock_i_ino(sk));
>> +		sprintf(bo->procname, "%llu", sock_i_ino(sk));
> 
> This hunk is not part of 68973f9db761 ("can: bcm: defer rx_op deallocation
> to workqueue to fix thrtimer UAF").  It belongs to 0fe27e598592 ("net:
> change sock.sk_ino and sock_i_ino() to u64"), which is not in 5.15.y -
> sock_i_ino() still returns unsigned long there.  The result is a -Wformat
> warning (a hard build failure under CONFIG_WERROR) and, on 32-bit arches, a
> /proc/net/can-bcm/ file name built partly out of adjacent stack.
> 
> Patches 2/9 to 9/9 look fine on both 5.10.y and 5.15.y.  Could you respin
> 1/9 without that hunk?  I'll take the full series once it's in.
> 

[PATCH 5.15.y v2 1/9] can: bcm: defer rx_op deallocation to workqueue to 
fix thrtimer UAF

without the "%llu" hunk is here:

https://lore.kernel.org/stable/20260728163944.24110-1-socketcan@hartkopp.net/

Many thanks!
Oliver

