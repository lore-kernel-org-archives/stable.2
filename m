Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8149235B64C;
	Tue, 15 Sep 2026 06:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789455131; cv=none; b=LZ4nxQAYSbPgel/P9zcplOkZ5hIzCGxECeu4NwvHdetVRrETsfJ49QVgvwr+HkejJRMZisc2CI2QoH/Enzx+KrjkDNDa+zVU4VnMMfDZe2qdr88JUwIv63qtiP5+cxv/s9AL4zlJbW4CoOJ8QWrKtyytkPSi7FT0QSD+V23Ow3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789455131; c=relaxed/simple;
	bh=/TQy3qiMw8iEsxT8Jzfxk+BL0t9vtrxnE8kU3OWgP10=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RcRWUcsf5pzi1Pzp9sKK5x6qUOl8tOz3sBSaMR9nE/Ona0lKeNbOcRYN4E9v0xbIoJI6+OzmzdRb7wQhiSnJXe4LleEC2+2Bt/KeBl+hYWbm+0Iiu2j1hkpWyqVfN9TS6sVYPkML3SskQ8rprIfOg4r6tWbc8FwXyWyGBY20EaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=je8mUhFG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="je8mUhFG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C992B1F000FF;
	Tue, 15 Sep 2026 06:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789455130;
	bh=AspbTrJVCUnV7I4/gkTbQUtC1LqlvAsH2L1l4E3fwnc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=je8mUhFG76eq6HMev1zucBla6iYQwjUG/MREUlqngwyvDoTu25wgXpXylhQo11dnl
	 T44OkJBkPbVz7jmai7IpUA+Viva8vIE5WwiyM7fEBLBWISQb30HLBn/KzIxT/yIjSx
	 D0YuVGs72+JZzqtBssifHKcQmGL3hcda6VdmnlPJk2XNx98IIc/zBzVZMvIDnP2mho
	 FscBn+3AlcZj/uowI0BimP98o5SlRC/X1Lch2pgtOygeBvzdOxk5YZq1Qdth9fqPrY
	 pjEz/XPM2EoCr8H2adRSPWdQvhWLj5E/CSuYjLihn8adWAgbjfqOyt1FL5K/tOKU8m
	 SaSWRRPXnVOKw==
From: Niklas Cassel <cassel@kernel.org>
To: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, 
 linux-ide@vger.kernel.org, Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: stable@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20260915014714.41274-1-enelsonmoore@gmail.com>
References: <20260915014714.41274-1-enelsonmoore@gmail.com>
Subject: Re: [PATCH] ata: sata_inic162x: remove dangerous broken driver
Message-Id: <178945512853.665610.9001972576938691195.b4-ty@kernel.org>
Date: Tue, 15 Sep 2026 08:52:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Mon, 14 Sep 2026 18:47:09 -0700, Ethan Nelson-Moore wrote:
> The sata_inic162x driver was labeled as "very experimental" in
> commit bb9696192826 ("libata: make it clear that sata_inic162x is
> experimental") due to data corruption issues, but not marked as broken.
> Since then, no changes have been made to it that could fix these
> issues. Since the driver was not marked as broken, and the message
> about potential data corruption is only visible in the code and dmesg,
> it is possible that someone could enable the driver without realizing
> its potential for data corruption. Remove the driver to protect users'
> data.
> 
> [...]

Applied to libata/linux.git (for-7.4), thanks!

[1/1] ata: sata_inic162x: remove dangerous broken driver
      https://git.kernel.org/libata/linux/c/96fdeb7e

Kind regards,
Niklas

