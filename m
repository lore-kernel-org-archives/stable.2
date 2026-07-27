Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B532D3ECF;
	Mon, 27 Jul 2026 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157509; cv=none; b=mtzraw21qOY+KU5dMlVn7rx0xARZ9+nw/wXYdsKeCrhMac/Axf6BP556L1EU2MwXpzRyFr8brgiHxX6A9rJy1bPhORYVLHuVkJa+wdfifAwznW29PXI2VihZTDz+wIVpAT9S5M6U888zUBMw5jIgjYN9r6JLvmhp2v0JG0AktnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157509; c=relaxed/simple;
	bh=E26+rfnP1QNCeEEf+AWaLyMElB6bW4QFQJgBelhecak=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HCgtH1KhenU+TXViLe1TbWuNLIuTlRUaAKR3+iKtsIfDTDLRb/276xiviBN1jD/IIf5HmDUmWkqrXw+vhACBZZeDerHy8JN9bdEOeg5QrFBPI6eqtBk/ZAVzW0pDM6yMSjf/ralWx88VZiFAjV+mz4bs7LXXQLL+6geY1Fk4uRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECFE1F000E9;
	Mon, 27 Jul 2026 13:05:08 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 9422F18095E; Mon, 27 Jul 2026 15:05:06 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, andersson@kernel.org, neil.armstrong@linaro.org, 
 HyeongJun An <sammiee5311@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260727074119.2585463-1-sammiee5311@gmail.com>
References: <20260727074119.2585463-1-sammiee5311@gmail.com>
Subject: Re: [PATCH] power: supply: qcom_battmgr: terminate the strings
 from firmware
Message-Id: <178515750659.21558.14762461110413105920.b4-ty@collabora.com>
Date: Mon, 27 Jul 2026 15:05:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 27 Jul 2026 16:41:19 +0900, HyeongJun An wrote:
> The qcom_battmgr_sc8280xp_strcpy() takes a Pascal-style string when the
> firmware sends one. Otherwise it copies all BATTMGR_STRING_LEN bytes and
> leaves the destination without a terminator.
> 
> Those destinations are model_number, serial_number and oem_info, each
> BATTMGR_STRING_LEN and declared next to each other. They go out to user
> space as val->strval, which power_supply_format_property() prints with
> "%s", so a firmware string that fills the whole field makes that read run
> into the following members.
> 
> [...]

Applied, thanks!

[1/1] power: supply: qcom_battmgr: terminate the strings from firmware
      commit: ab1112df8f4ffa88cb024dd370c432ced80f77d8

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

