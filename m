Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537221;
	b=FDWaamezdEHHtKWbfKYhxRI+ZL53B3eCbiqJvmgpMVG1VElM1zwXuAUt+4SiqqIdtFZw
	 4H7clcwmLI0HZJTtJXUPmcXerb/L++CEEy51++8bbmpwZm/qO3S5KvI6ryri8StHE8ov1
	 HxJILWUzDw7QiJkxvmvPGCTCor0wMRDCa6UuB6teEW2E2VVY43ROLNpnWLlruw2tmgegr
	 tKkYJtbk2Shrw05cgeo0VF/JQRh2nbcCwUWPWlfBXQ3fbeC08YUyVFrCPX/D5XrKq7M2F
	 jzXr0dfG2exWx5OJglXB6u85Rccm/rkJZ6Jn0GEKxpicsGrxkSvQLoNNvld3zeE+Bnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537221;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aLmJuJGbCzGbs+3KPFGFGdpt1U6F9QLWDWsM2U/Wzno=;
	b=b09C/uWLpY1nopQwHgVibMndDpl9nIZ+1R1W0iLW/Y8YBf+snNMC29yn+lxEtSwhdZp/
	 1VdmZBr/C+tBWjLtc1atJwcF/pd/uTdLExfevqaLtXrb/yn5+GKBkgP/RSVmht8kpTXb1
	 Aq3tPb03qvdYkuwYBBs0uyn033SkuFi37z5+Fe97amM3W3D05NNLdhho+UTK5puYQNzWI
	 tZAol+mzQHVJLqrCASOgzvhQ+lthpW5579eAzj/XDRUdQbDPGtQRinf20lJnFwLN3pO4k
	 wqqCdnMe8+rPSfPXoFUmsnAjVi+N/V/0b3wzTiv+DcroCN1vRUG6H1fTAEXO3cP1gCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F9QpUrtt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA31606A330;
	Fri, 13 Nov 2026 02:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F9QpUrtt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8E01F000C4;
	Fri, 13 Nov 2026 02:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794537221;
	bh=aLmJuJGbCzGbs+3KPFGFGdpt1U6F9QLWDWsM2U/Wzno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F9QpUrttHUPI7phi2f5tCBzpxqNgDeNuelcu+QDRnUGL1IY1uV+7SDEq3LfasQ1Iz
	 +IZgOqSBg1OnmqfdHX/xUQQDD8PXj2O2CCA6GVvx5DitB/DcJ53f6Mrfj44rayrb9h
	 vp22Tv33Oj6OL+XOCSDFbQ8OWj03CyZzXUj73PbCG4Yi/J9lJ8SJKLN4AfilHqzURP
	 BfYZzDdxpwA1/4ofhrrR1FNky8aCkKyEvxgm3kwFSx4vNje6T7ejMDwvvU8q5fYa3k
	 HnyFec8mdO1N/73I+tXTIAoPJ3k+YUoj16BJAeLoFra3fjHlvIcUJhpqc5GytnSlko
	 MwzZQU4KI2miA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org,
	mehmet.fide@screeningeagle.com,
	Mehmet Fide <mehmet.fide@gmail.com>
Subject: Re: Please apply the rtw88 USB after-DTIM queue fixes to 7.3.y, 6.18.y, 6.12.y and 6.6.y
Date: Thu, 12 Nov 2026 21:33:21 -0500
Message-ID: <daily-reply-2026-11-12-3716209072@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111232037.628934-1-mehmet.fide@gmail.com>
References: <20261111232037.628934-1-mehmet.fide@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2026-11-12, Mehmet Fide wrote:
> Please apply the rtw88 USB after-DTIM queue fixes to 7.3.y, 6.18.y, 6.12.y and 6.6.y
> Hi,
> please consider these four commits, in this order, for the 7.3.y, 6.18.y,
> 6.12.y and 6.6.y stable trees:

Queued for 7.3, 6.18, 6.12 and 6.6, thanks.


-- 
Thanks,
Sasha
