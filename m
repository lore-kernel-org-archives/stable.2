Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A714A5EB4;
	Mon, 12 Oct 2026 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791822153; cv=none; b=WyBaaX2ak+M51w5avu+aw90EoLHA76iCbtZKLdcIpA9OMhfkuVfQcGwWr0PNnau2FfgfT/gReTTuRvBxyJYTjgXn8UMfNPM1c79IG4KD6tGCCWGwwcF5r4ixeO7/mMo8xf/XEfIIzGuQTVf2uTz69wiD/NpHt9KoupyOzueRbK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791822153; c=relaxed/simple;
	bh=bElcF85UnTsPsK3JmZkckN1qWbGReCw8cJlM4YW08SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzPRugMJYl4x4CZbIL1MPnUqOqv0SOsyWX8/PCw3Tpgl2ezeMC0qlx3GII83Gz+PKq1T8R0ukD2TmlK8408dinxfXH2J6l0W83TUpYlUw3TzVeXJdJJ80wbW4Ayhn9rhtTVQWetg1Db+21WnlMKIYHdCdIuyhrWvWSEQkhL6pz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glTKqFKR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glTKqFKR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50551F0089C;
	Mon, 12 Oct 2026 16:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791822151;
	bh=ujVlQVHq5JIQ0O1pcio2HBL6zzvo1/h8W5FdQ/HFDtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=glTKqFKRA/lzgraEST5OyD7TVH8Xu3LxK2obpvhfPcMC2356ApAlxVAqGTyQHyst9
	 c+pqw6cXo9IyynvNGf5J37T19hoWN7POrnGTk4nDaZcZRBkrUuskNuzdsPiJvBR8Jn
	 gsnZw54RYV3AiCfWvHdZteUzpVtVIEZrfcpTSbQDCbJWiMoqKcjOiUOHbjh5GKZqnV
	 urziov9pq42Hl5VVkY6b3hlUddeazbr+pQmtAWCinw4hVHXZcOeMjv7by+zdygmrV3
	 8FuN25QV6QGVhfmOonKOWdEtu/+5Q8I7j3MTczT+pBPtFFiBrH51mXKM41Fraiou+j
	 lf6TUYTo/ODkg==
Date: Mon, 12 Oct 2026 21:52:23 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: =?utf-8?B?RnJhbsOnb2lz?= Roux <franzelfranzel@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] power: sequencing: qcom-wcn: power off WLAN at probe
Message-ID: <as0JBsiiR1T94Adj@debian>
References: <20261004165124.4277-1-franzelfranzel@gmail.com>
 <CAMRc=Mf_szZhsZEB8pmZkGh5pB6AEims68rc1tXE=XGAcMuEvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mf_szZhsZEB8pmZkGh5pB6AEims68rc1tXE=XGAcMuEvg@mail.gmail.com>

On Tue, Oct 06, 2026 at 11:03:17AM +0300, Bartosz Golaszewski wrote:
> On Sun, 4 Oct 2026 18:51:24 +0200, "François Roux"
> <franzelfranzel@gmail.com> said:
> > The WLAN enable GPIO is requested with GPIOD_ASIS and then kept at its
> > current level, so that a WLAN module left powered on by the firmware is
> > not switched off. The FIXME explains why: toggling it would take the
> > PCIe link down, and the controller driver could not recover from that.
> >
> > That reasoning held while the PCIe link was trained before the
> > sequencer probed. Since commit b921aa3f8dec ("PCI/pwrctrl: Switch to
> > pwrctrl create, power on/off, destroy APIs"), qcom_pcie_host_init()
> > powers the endpoint through pwrctrl before it starts link training, and
> > defers until the pwrctrl driver is bound. That driver cannot bind
> > before this sequencer has probed. Power-on therefore always comes
> > before link training, and keeping the firmware state is now harmful.
> >
> > On the Microsoft Surface Pro 11 (X1E80100), the WCN7850 sits on a
> > PCIe port without a PERST# GPIO. While pci-pwrctrl-pwrseq is not yet
> > bound, the host init is deferred about ten times, and each attempt
> > powers the PHY and controller back down. The later power-on only sets
> > a GPIO that is already high, so the chip is never reset and the link
> > never comes up:
> >
> >   qcom-pcie 1c08000.pcie: Device found, but not active
> >
> > The endpoint is not enumerated and ath12k never probes. Bluetooth on
> > the same chip fails too ("QCA Failed to send TLV segment (-110)").
> >
> > Request the GPIO as GPIOD_OUT_LOW. The chip is then off when the
> > sequencer probes, and pwrctrl powers it up cleanly right before link
> > training. Drop the FIXME and the code that preserved the firmware
> > state.
> >
> > Tested on a Surface Pro 11:
> >  - b921aa3f8dec plus a one-line version of this change: endpoint
> >    enumerated at 2.4 s, ath12k and Bluetooth working.
> >  - next-20260929 plus this patch: "PCIe Gen.3 x2 link up" at 3.4 s,
> >    ath12k and Bluetooth working, Wi-Fi connected.
> > Without the change, neither kernel enumerates the endpoint.
> >
> > The culprit was found by bisecting v6.17..v7.1, with the DTB and
> > .config held constant.
> >
> > Fixes: b921aa3f8dec ("PCI/pwrctrl: Switch to pwrctrl create, power on/off, destroy APIs")
> > Closes: https://lore.kernel.org/all/CAPjyS8dY0Q_o3XmFjuKZZsjhzhoSNL+ZGJtw5cQt8HiV3sUtxA@mail.gmail.com/
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Signed-off-by: François Roux <franzelfranzel@gmail.com>
> > ---
> 
> Mani: this looks good to me, any objections to me queuing it for v7.3?
> 

No objections from me. As the commit message stated clearly, we no longer need
to rely on firmware configured state.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
