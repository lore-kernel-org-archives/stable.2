Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314AE3CBE69;
	Mon,  6 Jul 2026 06:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319071; cv=none; b=O4NvwJnnnda/jUyXSWrKSX6aQmuj+eDC5V+jLM+mMEQ/tr2g5ZCBE82DYFFMn9BIqUAzwJF6OFU/teG7n33sWoSuGD1RiTdCFQATicdKrcAyxWlt9JkcNVjkhq6yPMxCmYrVUb3BoENhFP4F0eaivnP9h0iMHaCqmP2n0RjoDVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319071; c=relaxed/simple;
	bh=FHTwWWdpbmraH3fKYY0ka1jQ+eV9iOVLeNq9bpYd6lA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AWpMLSdhRVZWmG1zh8Igf/aiZy3SQ2vBeY8iAW0WHCtklg1f1bdE857P+kZcj12GKekZWohClR1ZS6mYI2sQe5QETH5j6sNguNUVmHYu+LragwTdE1yGhjlzZJmxqLAwMEjTya31oN7pjbNUNxOAe6wik9OB7GT7EPUZyCXVJbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wC3Qc1A6; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wC3Qc1A6"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 26C281A0E7F;
	Mon,  6 Jul 2026 06:24:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E7A91601A2;
	Mon,  6 Jul 2026 06:24:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7E4BE11BB9890;
	Mon,  6 Jul 2026 08:24:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783319054; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3IbFos0UeA5hamgUTU74OZqNtIk1cvZ107rKx8smnWk=;
	b=wC3Qc1A6ke/5jyvpXClPdyJj6j+KsAzGM8khmdwAPlCrl7WWxNRvQOQltzSN3YNsQPz0QG
	/Jz4zseEy/9KVscxDWYrFTzh3M6rvhrjROkZ4Aw26YextQKVVqqXA4CKKBUQY4dwwYo4ap
	gsbkK7N03c7JYWdfL0vQ23jTIXb6SsGcYdaDGX0Kd67KIIYJqbaLebfQ+MjjpYarv/4AnN
	SMYOPgyo6yu/2eX5DzDB+9wpl3D9EnhUpVI/uZuzfWAX1JZcMarCkCvozdSe3jvprscHXw
	fugmy/DlsW8mqzhs6p8z/cNmhOcHJVsWnjK15bDeLOvGeUbCNtfbRxicRC6FBA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: raoxu <raoxu@uniontech.com>
Cc: richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <A9EF5AD55FADC312+20260626021338.3744161-1-raoxu@uniontech.com>
References: <A9EF5AD55FADC312+20260626021338.3744161-1-raoxu@uniontech.com>
Subject: Re: [PATCH v2] mtd: virt-concat: free duplicate generated name
Message-Id: <178331905244.868671.13228037841179082405.b4-ty@bootlin.com>
Date: Mon, 06 Jul 2026 08:24:12 +0200
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

On Fri, 26 Jun 2026 10:13:38 +0800, raoxu wrote:
> Every MTD registration runs mtd_virt_concat_create_join().  Once a
> virtual concat has already been registered, the function builds the same
> name again and takes the equal-name branch.  That branch skips to the
> next item without freeing the newly allocated string.
> 
> Free the temporary name before continuing.
> 
> [...]

Applied to mtd/fixes, thanks!

[1/1] mtd: virt-concat: free duplicate generated name
      commit: caa0ecbeff4f7fbf70f22bd8ca598918bffb1b78

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

