Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D777D4AC167;
	Fri, 25 Sep 2026 14:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346531; cv=none; b=B5sjVNDbu8VkF4ZpAl0FJNyt9jUkx2jD3CoZWMr9g2EAwFuIHU+OB4OBbXxJIv+2ykmZrIHUwz0mENGrgmcswwMhMD61Og+waTcr8dCq1YSwtqbHyrC+n67KuquauOZBZLfAs2FXdiFc5MHkiaAbiqvzGH1ulEQfIwyvYMflBos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346531; c=relaxed/simple;
	bh=5gtiiDiK+HpWvPtqxf0XoX4Rpnqasvbc0Su0oWao/Io=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qUrPTHh7QjM689NLwGRpqniVIljvXE3zQgasX30aJebs96QlBeNsnYG6bTN6uUIFgXEkAfN8+FHekhXPhF/Nfyzul6FgqFULpQiv0OEflwW7rwnSZV9tvnV4i16H3uJkc6OQcL4tk3KHQxfXQUDV6i+ZONQZJtWP94xzNChHQeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Yas0I/aM; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Yas0I/aM"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5E3A94E41072;
	Fri, 25 Sep 2026 14:28:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3259E6073B;
	Fri, 25 Sep 2026 14:28:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8A5D9102F1E10;
	Fri, 25 Sep 2026 16:28:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790346523; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qQValb4cdXQVQPWw0cUkOsUztHcoNAL4ungnrJTbea0=;
	b=Yas0I/aMMutQJ5rQT1HRAoH/UT2oGQTScVXHc/N/RpiVYPjCtWZ6NS2B26ruvVTZthFVIS
	MUhfMNMcHUCFhRxB+MsT/8RiaPm61lS9HEFPgCB0uZdVPzFXOyypbnqikN+71qkd4pfYXw
	gmzyjlTFATxm5o3Acx9goeh8lGrNm4xWM9Fl1LT7odQ3fyIQXw+TNs9cntB5DZQTaz8uYt
	u3z/3LbetShpZJf3JDw5zr5HytNqqUM53y4IDF6mLG4Y+sRI56eJABV4heQ10MRVLeLBvW
	nIU7nMABZUb0oW38ooWonS1VKaHJrR1hdBQucNNeUbSgC4lfkEeQ7BBxSfq4uQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: akpm@osdl.org, Wentao Liang <vulab@iscas.ac.cn>
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, richard@nod.at, vigneshr@ti.com, 
 stable@vger.kernel.org
In-Reply-To: <20260917102051.2146567-1-vulab@iscas.ac.cn>
References: <20260917102051.2146567-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] mtd: amd76xrom: Fix PCI device reference leak in
 amd76xrom_init_one()
Message-Id: <179034652046.1166139.1375101716012625421.b4-ty@bootlin.com>
Date: Fri, 25 Sep 2026 16:28:40 +0200
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

On Thu, 17 Sep 2026 10:20:51 +0000, Wentao Liang wrote:
> init_amd76xrom() obtains the PCI device with pci_get_device() and
> hands the reference over to amd76xrom_init_one(), which stores it in
> window->pdev.  When reserving the ROM window fails, that function
> returns -EBUSY directly instead of going through amd76xrom_cleanup(),
> so the reference is neither released nor cleared.
> 
> Drop the reference and clear window->pdev on that path.
> 
> [...]

Applied to mtd/next, thanks!

[1/1] mtd: amd76xrom: Fix PCI device reference leak in amd76xrom_init_one()
      commit: 1a122f5fecbabd47b81b1be3f0934f57b78aad42

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

