Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBF747D935;
	Fri, 31 Jul 2026 18:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785523849; cv=none; b=Zhdvqzd44fC2mihrumaxlE8DLPyw+pjGvl2Z16feffiqJH0iExmJdEC8qdPneHXp3SY88NM1OeWOdGmy+PrjCfmNWHlOQ7PLbn7TtWsJCLGs3NNCeUMrowCfVvWUSXwtPrLfq7EaOHJxrP2MlcATNAkAsY/IH79EpgFMlmAV0KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785523849; c=relaxed/simple;
	bh=iuD2caIWLoFfo2DO19k6Afu5EZdez9fn0VypnXxUCM4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XDIMzY/hwWChV5hTv/kYh0gW67bM+cTuLrE0RTPT2DObatwlMq7mDxGzMoKJgxH2YB8iS2RFCWzMtKVFVtj54fLe8Wx1DndtzPnBik4R1IaZF8/w9rLSJ6a4diQkdXDqbNJNGrla+HKD0ENKIC0P2GgD6xGuClOOHXFBJnojH2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HljZ/0kf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HljZ/0kf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045B91F00ADB;
	Fri, 31 Jul 2026 18:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785523848;
	bh=qgjH+9WbOKg3N2hR73eQVUhm5gMh/GrvSca8kplOAiU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HljZ/0kf3juyt12+SDJGvNH08vTqSnPzl602dJ2lekHthafmBNV+lTrH83HGrE02t
	 MAn3OuvX/ggUKijoglUPsaWsg2ypThTgDco12G1rRwGKAW5xbuCR9sT19zl//ESHUd
	 PpxZbhmtnD3NuQDC7FXOrDp9CgSMkcEdtNxwPJhk/qJBvSxhuIJ3XzZRljUKsMRjel
	 sTFdwbVwKZMrnYnuW/HWYH9NooYlXno42B4lgDjReQ8wP+86lDZ+7Mt6e634x+48v0
	 pZUA+m/XhstmBzDmyEgL/EoTAw0gu0jIwTVHdtWq54uwhj+lu49NPg7TDJl/dNhrhY
	 WYfZupv1MCNPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197EE39263BC;
	Fri, 31 Jul 2026 18:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_aml: validate firmware segment lengths
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178552381063.861446.12918007328883610653.git-patchwork-notify@kernel.org>
Date: Fri, 31 Jul 2026 18:50:10 +0000
References: <20260730122028.98159-1-acharyalaxman8848@gmail.com>
In-Reply-To: <20260730122028.98159-1-acharyalaxman8848@gmail.com>
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: yang.li@amlogic.com, marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 30 Jul 2026 18:05:28 +0545 you wrote:
> aml_download_firmware() reads two lengths from the firmware header and
> uses them to build pointers before checking that the header and segment
> data are present. A truncated or inconsistent firmware image can make
> the driver read past firmware->data while constructing TCI commands.
> 
> Reject images shorter than the header and ensure that the ICCM and DCCM
> ranges fit within the loaded firmware before downloading either segment.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_aml: validate firmware segment lengths
    https://git.kernel.org/bluetooth/bluetooth-next/c/e08aeef6ec5b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


