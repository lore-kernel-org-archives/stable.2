Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98808382381;
	Fri,  4 Sep 2026 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788543511; cv=none; b=bKHQWuBE1K+w7jRW7YwKmrGIBvAKxoSkJKZJW6iS3VvTk9hcdSX9xpVCp/+9MDqZRNA3THoT7TEJjM9WbJZm5wUXIaXS5LHQ1LggMz3A0SXnguTIZE4X5hvRah+HkT9jZ8EPowAAOsQ0lkjUT483gJRdQ00b0Xl3y1WmH1KzeMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788543511; c=relaxed/simple;
	bh=IedJpyU/JUTRYeEU+8z8uMuF1mwacK+yULgKWAsKfuc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CiIic5696BwMp+dIjSLXgZRVc4ayk18HyO9hc8/b5clBSDp19+dJRLRimRtE0hBQrfUpNSXlMHQ0TBVamxeCMbPRkzYnE0/o7w7D8HxkRYCi2W2Kd+hTlbbq7qS+EDlaYjKIiep0kQdviyl5K5zBPyZby69j7u7ZHr2kFhXNDKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NH5S48NA; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NH5S48NA"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D53441A19B9;
	Fri,  4 Sep 2026 17:38:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AA6016057F;
	Fri,  4 Sep 2026 17:38:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7DD3D11C79AE2;
	Fri,  4 Sep 2026 19:38:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788543504; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+11RD2VkhzWbJPSklHtMOUDZPRa5mUWSSSuUxHURdRo=;
	b=NH5S48NA0wszJyBXRhzNNDfsawFbJvBHPOTKtt2Pflkp+LgdLzgr7Ce5NfzlbaELqLUYob
	70E+z7KI0Huy/ZrU75B9RRY4z5mxs3RClOOZaL+OUFtiTGBvw0MGt74DXPnkQ94xfe6UcW
	RK963upBrxsfzsGybnVxrlKaIWjT0zz4acv2SAzzw88LMrELHS1jNAoJzFIr8oC4J/7s3f
	fdefzcFwQhwuvGCZKDx8ubtwgRuhwCbzzIuzr1Zm3r1/a/k9DPnVlOjco1L+SO7DqhlIua
	lpT+GgQymHuPps/NS3cDLap8SyCq2hLQY8TiNW+37UWId2eT6Y/lynyn1IeZ6w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Alexander Usyskin <alexander.usyskin@intel.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Menachem Adin <menachem.adin@intel.com>, stable@vger.kernel.org
In-Reply-To: <20260827-mtd_eraze_to_fix-v2-1-1395ae4fb795@intel.com>
References: <20260827-mtd_eraze_to_fix-v2-1-1395ae4fb795@intel.com>
Subject: Re: [PATCH v2] mtd: mtd_intel_dg: reset poll counter for each
 erase
Message-Id: <178854350239.1467647.10362961851699895483.b4-ty@bootlin.com>
Date: Fri, 04 Sep 2026 19:38:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 27 Aug 2026 08:11:56 +0300, Alexander Usyskin wrote:
> The non-posted erase polling counter is initialized only once per MTD
> erase request. Large requests therefore share the polling budget across
> all 4K erase commands and can fail with -ETIME even though no individual
> command timed out.
> 
> Reset the counter for each 4K erase command so every operation gets the
> intended completion timeout.
> 
> [...]

Applied to mtd/fixes, thanks!

[1/1] mtd: mtd_intel_dg: reset poll counter for each erase
      commit: e0a84c2fc29dc23f9331a4a9f236ef61c941c3a4

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

