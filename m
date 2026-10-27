Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118439;
	b=h5x8Ln38tslcLve0bFjgs5uu9SlhnDpguhX75Ln7VCX0KwfSMuXEPkE2GBqltY5rVTfN
	 cuk107hj2dSkV5ql8gM32tKQM3r7m8a3Nkss5mGEZxo+PmSajEgr/JXbJMi8OfrSzWarq
	 vqu0u3DgmQxG/NRIpi7ChXodtWv0HirKmZK3iAEdZMq6LAhjcflzUCcQS1DV+Vm/ir0bW
	 xG73nRUdKZi2Z9WLuEKRbIVb6pQx04NHKGSZMBfgwoMssWYlKjfvdCOlElsRGOo1tDunG
	 Ji5KxEADcQoDl18BNTqWUARmTnyOca2xlJajT9qodK34Gw/go8hgn1DklnQvExctsmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118439;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=0neYk5YrzikJjtW8ZXq29ALRyYZ/j0M4VHLdoq0EH3s=;
	b=J09hGdWdhQ/ypUPrWmqFSBt7haS4pb9AMkXVYgoMNfQ/RZ2CVTjw0LxtvBkBLW5Tvfpv
	 H4IGPadeFKSMt0cNrhygHYeBEE21/tqAPUqPP05BRyFLnrfLGuC8QJ1fD4v4wA8bOuPCT
	 FF98F0pVszp1k+clwcX9dHITiJ+Gy5OWV7a8w4ofhx7gFxqoa2F6SZX+qwSBqUN0vVlza
	 K6Ma+maspwDGWEyPBzyqoTAv5H8T7obRs9M3+XxbzwlnuK11Irf1/PV3XDHrycNZYkBMA
	 BbB29PaAPDD2qgeshmv8ESVr3w3f6uyBYkTyFTYtbssW2p5wzDtcNJBDjPkTgWafWyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XdZujaRj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF3C606A31A;
	Tue, 27 Oct 2026 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XdZujaRj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98FC61F01825;
	Tue, 27 Oct 2026 16:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793118439;
	bh=0neYk5YrzikJjtW8ZXq29ALRyYZ/j0M4VHLdoq0EH3s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=XdZujaRj4O5z8foVBYdwhtk7pEGZ0SMFB+QidK1Qx8Fx7eUnjLyrXUkfs3YwZdzaO
	 AIuoyY9s5ByV8uDtnz7pL0yt75d1psMuK1r3gvEjRULw00dcw5Bi0KxgG6CDv9CdBB
	 lAPO/auka0BC0Rxv+lDjicwtqAAgnrs4SON8K5RRReQDwjB0a9DOdMpkEr4XVnecrE
	 0FsGqAk6tC2ajtJtYA2AjZQusgzf4pIu6xYsZwefsCYs5Pb6NJ/DlFSFOL3wyzzocf
	 I8mFGtPZTDbQabMkM2maMGWem7yM7pHoVHn23lJyF3M51RQyoxq3O6xWInuyCtddK6
	 n4lnbOiCU4W1A==
From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, Jeff Barnes <jeffbarnes@linux.microsoft.com>
Cc: minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com, 
 lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
 bhelgaas@google.com, Zhiqiang.Hou@nxp.com, 
 easwar.hariharan@linux.microsoft.com, linuxppc-dev@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261008173641.199142-1-jeffbarnes@linux.microsoft.com>
References: <20261008173641.199142-1-jeffbarnes@linux.microsoft.com>
Subject: Re: [PATCH v3] Revert "PCI: layerscape: Change default error
 response behavior"
Message-Id: <179311842858.16692.9389173908526877581.b4-ty@b4>
Date: Tue, 27 Oct 2026 21:57:08 +0530
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=350;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=oSZljKFgqNZT5ufuzpZRuVDIEd35DWYMJ1TbziJ9xds=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq4NDgZ5zady26m9K6haj/wBnaklC2m6VON1Uth
 fthEm/97AmJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCauDQ4AAKCRBVnxHm/pHO
 9Rg0B/0Yp4irU5NLfav7GFd57ZBMTVchSr4AOx/QhQT/NYiTpWZbAXk3PqQ+jiDyz6ve1sACZcb
 FIik6/0SbB2ZHYg1vpCv+QvsGauCZJkRCpE/LgYO1EcILA5JuIH57hoNl7Fs+Mh3H7qMSGv1IsE
 FBhn5M4BFnz87Y882zs/nUXVmlLRc90xr08qKclMYfJzlv0m0l4hrtfdyY5v+Z6E/15HVuKxTNS
 YzwOzzj7rETJVPX04kItadmv6KoQGSfYCZOEF2o5gdlTF/YfQg3cuavMRHDMFxHSa0BWMHTbKtk
 ZlAgEgsj6CoZVQ8ZeG14PtPR9eX2G2DuV6jeEGI+vzN8aHQZ
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Thu, 08 Oct 2026 13:36:41 -0400, Jeff Barnes wrote:
> Revert "PCI: layerscape: Change default error response behavior"

Applied, thanks!

[1/1] Revert "PCI: layerscape: Change default error response behavior"
      commit: d981c566d283ca074df2e485078b369cff088349

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


