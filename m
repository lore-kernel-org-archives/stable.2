Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339BC483807;
	Tue,  1 Sep 2026 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282828; cv=none; b=RMNYv/9/M2MzTjX3KssMoQLvxnHffo86fA7FgwI0A1dHZ3Idm6XOss6BiGoW39M5LgPm0oRnQ2yXuIo2IVsbByxAweNyIxFQSr8E/i9Kx579nJbv2r/tKFEhqLKMq7oTPhz51ZWQHVnB1BXDIy7hpEBMg9aci3fCOXrFTOtMeIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282828; c=relaxed/simple;
	bh=6Vb2OqsDmeMbg5kW+Dx7Qz5jOzmdEpftTDrMCix0JG0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fH4OYxJ6/BgD6pi7KRxgN3APriOqtCYHK/JB7s1AyXIoRdg5XpV1UHnzElByTija4PnQRtjAajx2wa9JqSEBDcmroBZ9UcLGJE7B77wmd526gv2TASMYlOqKxE0FjZQGdsi1JTpCm7dH5AJVF41rQKe9fuVvlZbY1z+l/vrsrZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+gvtbiV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+gvtbiV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1C71F000E9;
	Tue,  1 Sep 2026 17:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788282827;
	bh=I2oTOPasIdopqjB4ViJz164Yqi5xIrItFCO9/E2j5gA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=E+gvtbiVFSlojzGAVrOEZ/u1NBWJruALIGlgyelAZP/u+dfdB5sqbuAUOUcoAIDmT
	 pFGyQIWkd/7NXylkc8eam+YeaJeIqcZ3LGm2UHoQqIJ8nppE5JEAaHdxMyYO2nEQH1
	 T9n6sOfbwxsluMJsleTP/lt7YOGtr9tpzYhDu2bE2jkZ0+eF42qThncwbbSlGjYzOF
	 zuKl9pxQ0ILDQkEz0E2uritiK1KXfyyutprRaOwyx0HvzezZBa78/pR5D/I27KcfIO
	 UUvnF8b5Prmu8y1VGoJpU8n9NlHmTmHJbxQJn+BtbgILJJnX/cikEKGyOYidWWk8Ps
	 ZSm039mWAE3lw==
From: Vinod Koul <vkoul@kernel.org>
To: Ian Luites <ian@luites.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260831082534.224716-1-ian@luites.com>
References: <20260831082534.224716-1-ian@luites.com>
Subject: Re: [PATCH] soundwire: dmi-quirks: Disable ghost Realtek on Asus
 GX651AX
Message-Id: <178828282468.1394487.12334872911825820850.b4-ty@kernel.org>
Date: Tue, 01 Sep 2026 22:43:44 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 31 Aug 2026 08:25:47 +0000, Ian Luites wrote:
> The Asus ROG Zephyrus Duo GX651AX exposes a Realtek RT722 device in
> ACPI which does not exist in the physical hardware. The device remains
> unattached while the CS42L43 and both CS35L56 devices attach
> successfully.
> 
> This confuses the function topology machine driver into creating
> duplicate DAI links named SDW3-Playback-SimpleJack, and the sof_sdw
> probe fails with error -12. Add a model-specific quirk to remove the
> ghost RT722 device.
> 
> [...]

Applied, thanks!

[1/1] soundwire: dmi-quirks: Disable ghost Realtek on Asus GX651AX
      commit: 6d49beec658f61801e79019fd73691b17252dee3

Best regards,
-- 
~Vinod


