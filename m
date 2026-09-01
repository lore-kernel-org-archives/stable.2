Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E5D40B6C9;
	Tue,  1 Sep 2026 02:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788228609; cv=none; b=iACrj6kzThPVCodDEqETKLwKME6KFVTjkJAu+iJFwZm1w9CnsHj5lvfUDUGO1cUd/duhtqS/LjWj+84+AWGkPyZZ+YP15INh16gWVOruy++5Q7gOmWVMPUeMqbSTsXzOqhjgG09cM9/0II7Y1kryf6sANrwcNlyX3xSqSjTBGPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788228609; c=relaxed/simple;
	bh=xvaQTj1YwJf5V9NO3LpE3tjG1hU8Jroc60VNDG+eLrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CB/y+fgaOqaznCrC1KGInibt/mtbVFoGipsTWY3agKd2+fgVr+7+2eBXlAmkULRcP1J7fbUE/aWZwjXTh2v7VLK6njJPFlMO250Uly9u+lB+CRX46m11e49vIwibzPvyP5LdrY7jhAYZtab///AsZTI9e66fyuBgYDKYorMySX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0nvx9cl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0nvx9cl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882781F00ACF;
	Tue,  1 Sep 2026 02:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788228601;
	bh=/ETHjOMoxWmxmsZByUUKeE6TTPkX9y5GbMLcgDSZBUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D0nvx9clonYU05ssnfGbyFKZeFaQKO31pVkeKExjZX8wE763uzYyzgLkKuBLuiBmU
	 SJtGuDw/eHFqXSkNtG7dJkr/PXI5ijMI3iyzjA2QNF583STTVlUXbCKC2WP8S4SoGY
	 AIqxI9R4WtW3kCoHeG2SsdHUI9cRwKwgicAXy3cSw30gh2UrdtY6rzdgpnMbEe/E9Q
	 /fw4KoJ4o91ImQYTrHdy5tENUtxhot0NaX7kvz9AacdtZZjMUiM8NPdGaG9B5OzZj7
	 lAWCGl/f2NMTDDptSCkjjnyglpZe5knIw5RgPKCrLQfwADLaOf3Lq+QNsi60nX9OXk
	 DBgnYgB0jA9Hg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/4] Fix endian, overflow, and write-protection bugs in SE firmware loading
Date: Mon, 31 Aug 2026 21:09:35 -0500
Message-ID: <178822856276.1835959.8663134025896190257.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821-fix-write-to-read-only-firmware-buffer-v3-0-43e6a3abd651@oss.qualcomm.com>
References: <20260821-fix-write-to-read-only-firmware-buffer-v3-0-43e6a3abd651@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 21 Aug 2026 12:06:16 +0530, Viken Dadhaniya wrote:
> This series fixes four issues in geni_find_protocol_fw() and
> geni_load_se_fw(), all introduced by commit d4bf06592ad6 ("soc: qcom:
> geni-se: Add support to load QUP SE Firmware via Linux subsystem").
> 
> The most critical issue (patch 4/4) causes a level-3 permission fault
> and crashes the kernel during QUP firmware load on CentOS; writing through
> a non-const cast into a read-only firmware mapping is undefined behavior
> regardless of whether the fault is raised.
> 
> [...]

Applied, thanks!

[1/4] soc: qcom: geni-se: Fix endian conversion for serial_protocol comparison
      commit: 0231382f070df26a8b267f9e68c5440928b87c89
[2/4] soc: qcom: geni-se: Widen fw_size to u32 to prevent wrap-around
      commit: e976c865bf31b562ab3908f0f1e2160da77fa156
[3/4] soc: qcom: geni-se: Fix fw_end computed before round-up; propagate size to caller
      commit: d1750c530e9b9b75c8d1b29d3c76e052a049f51f
[4/4] soc: qcom: geni-se: Fix write to read-only firmware buffer
      commit: 28b9c15f1829fff7b26db0dbbbde1c6b466cb156

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
