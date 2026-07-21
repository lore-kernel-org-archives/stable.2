Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D2C3C0A14;
	Tue, 21 Jul 2026 12:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784635728; cv=none; b=sMlvkogekJXaccBFV/dljwokXzecDCoW0UpqPxkVCereK2sY5jWbPUlGsN8pVfHqzsV6GdO+eUHfTKZUOyzjtbrxxY6an3FSv/dic86JtfP2Q1Wxu5igpjX6SSyVnMxtgGiZs3ewGymoS2Fx7rxwYEOEJumAjoEbI/4398ZdzWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784635728; c=relaxed/simple;
	bh=yFFgQOmBPh7vK+W3p12LdBZVaWbFPaFPZZr0/4SOM2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ri4hFjYEsFte2ztUEYCQWHNTch7VZiYUlBCV+lJLADRCu3H8D0j6qnvh5rF+rLDUUuX8LshowcSQMj5A469zLFbNLIWVNcRAE9+dx72pWljwDefr9nbJY8pt0xTioi1s0kSXQaplu2cM5JHi45QLntVv4LETDLpsWYwXJwB2MEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L08iughh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L08iughh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BD01F00A3A;
	Tue, 21 Jul 2026 12:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784635727;
	bh=EuT4sDg4HlR86gYv/jrEyqKjLbKGrFxvTjplF7atFfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L08iughhXHiFdYJZ6p7jN5uA89DO1RiqbZnf0Kx1bOQYwlC5TGqKgWP0Qtf7v6uLM
	 Gx6ooqs/21wljXgxH/45nXjkB3YxVJ9W77ni28PpFf2dyGmkUXwqxYmJ71TdQpanoa
	 VhQWHS4jKsUhQVqfFl6Saa8gls6IkJ8TCHDZx9Idz7XDWwflcDVqjrMoyhfBz7FfbD
	 d26lNpSyDP+ibwdPBYLBEgVmVmG9jxSrXUQ+ioaAyF1NlRJNap59oUio6lI3c7XmQ/
	 dv+HTDB0rHHyoLiIFRKRhQW+jC55dH4BYxu4jFbpS2xCfj+ZiVDJlbuvRHTs0zHQuA
	 dZYAEIS15hD6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	stable-commits@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Hannes Reinecke <hare@suse.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: Patch "scsi: advansys: Drop ISA_DMA_API remnants" has been added to the 7.1-stable tree
Date: Tue, 21 Jul 2026 08:08:38 -0400
Message-ID: <20260721120236.100004-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <11842725-e747-4502-953c-996bb8d24da8@app.fastmail.com>
References: <20260720104750.157926-1-sashal@kernel.org> <11842725-e747-4502-953c-996bb8d24da8@app.fastmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jul 20, 2026 at 03:12:18PM +0200, Arnd Bergmann wrote:
>This is only a cleanup, not a bugfix.

Dropped from the 7.1, 6.18, 6.12, 6.6, and 5.15 queues, along with the
two dependencies it pulled into 5.15:

  - scsi: BusLogic: Remove bus_to_virt()
  - scsi: Add HAS_IOPORT dependencies

Thanks!

-- 
Thanks,
Sasha
