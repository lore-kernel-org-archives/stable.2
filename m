Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB0533C1AD
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111298; cv=none; b=hax4OSSqJ9HZrk+n06LRRiNU8HlqbRTNn1ugT7wswEqa3mZ3Y5cSc/azPherwAPiXaHC/N9I+Rb1jJVNUGeyok+7rQGmqLibHwXARnBspIT9upBxEd1fsK/a8a/51UP5l7QYMyhXoFrDEtCtMnfQW46AGUl1YgKSFX4+IN8qiC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111298; c=relaxed/simple;
	bh=8RffSfqXyqSVxqzscXTkTjqd76AQPP3M+wo2+zNYwfo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AH1CNCVkH2+aAbKpzFA0jHjJmQKMpN5KMv5ZeNWJDps/ZHqZKYSU4flNaXwZMRAA0+bGQsiPDTOao1zMPv0qfJFhjnTzl+PZM1ZxnaFgwJdGnQTIhgMfrwxHwUSuctoflDQkLsyvRzZviO6DD6UGqwK1ip6qut/CcCE1fCtLrfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=byG7ApHX; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="byG7ApHX"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A16941A14AF;
	Fri,  7 Aug 2026 14:01:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7596D603F0;
	Fri,  7 Aug 2026 14:01:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E49A911C3795D;
	Fri,  7 Aug 2026 16:01:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786111279; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8RffSfqXyqSVxqzscXTkTjqd76AQPP3M+wo2+zNYwfo=;
	b=byG7ApHXk4jnf4WYK3tg1LylDfclX/KCeVEJJ9QumgdmrxMonwP7doNFwZiVJM0V+jZk9q
	S4/q+a/sbGQypLZyn7uP/9zHeXzpoTmY31yPXS7Ghb3AHWPKw9i62pylxhx5QT/AHPj/0x
	vmKZPh7oD2EruiBylijKdnylSIeibQ835DM/6A7jcdKx4XaUcNyWt5FiDeW6Qu3qX3TRtk
	f2fcflSmcEA3FJrTtOW+tmKrqtFISbFoSteXYEyh1fqp9aC+XXB61e+9B9LokE7ERO3OCt
	INnQApxc9+TDvnfJtQegWvOg5bwI1apQn9sb1TLyr8r2NcKxh/mhYzlDTZYYIw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Michal Simek <michal.simek@amd.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH 0/4] rawnand: pl35x: Implement mixed ECC
In-Reply-To: <20260723-mix-ecc-v1-0-7361c3baeb07@bootlin.com> (Bastien
	Curutchet's message of "Thu, 23 Jul 2026 15:41:00 +0200")
References: <20260723-mix-ecc-v1-0-7361c3baeb07@bootlin.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 07 Aug 2026 16:01:17 +0200
Message-ID: <87cxvuav2q.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Bastien,

On 23/07/2026 at 15:41:00 +02, Bastien Curutchet <bastien.curutchet@bootlin=
.com> wrote:

> Hi all,
>
> This series addresses the PL353 errata "SLC ECC misses single error to
> bit0 byte0 and fails to detect some double error cases" (see 721059 in
> [1]).
>
> The ECC HW engine is known to be broken on this chip, it fails to detect
> some bitflips on reads.
>
> This series implements a mixed-ECC where the HW engine is used on writes
> and reads are done by software. To make it work, the software ECC has to
> use the same layout for the ECC bits than the HW engine. Patches 1 & 2
> add the PL35x ordering to the available orderings for soft ECC. Patches
> 3 & 4 make use of this ordering to implement the mixed-ECC for the PL353
> controller.
>
> Note that this series is based on top of nand/next.
>
> [1]: https://developer.arm.com/documentation/rlnc000227/a
>
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
> ---

There are several interesting Sashiko findings for this series, can you
please have a look?

Thanks!
Miqu=C3=A8l
