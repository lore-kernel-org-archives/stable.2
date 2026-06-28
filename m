Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C31B322DB7;
	Sun, 28 Jun 2026 04:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782619262; cv=none; b=LgJDtGoJ2BY73J0MR9T/I993hXnHS2izX+gLqC9pIDuepcZWkm8d2txSWsSHCnhBn2q0ukq/mECMc7G4S/N5EmjQue4yaWhl30xmWo16THd7s0MWcBUHcmjUgJUdxoX0cO84WIvzwPbCfSMJok6IvmNBfLQKXVhRRflxA//F1FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782619262; c=relaxed/simple;
	bh=JuqSsuGRZm86td/OJOSgdUJwm4qgsF47ge6PwftiZTE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VVT+LpGgrcPZ4BS5dLqnQxBoYtp0DYvcvHGDvuFFceTUkeSj/YUkOLmjsrDD1a935y4XYCwLdGQTLr7HMtal60ZHp7oZURrZZT+kqvKLzPksppRcigmKuU/i85j3XI4FUuc0pj4rcz0ODdhaTCmHpyzuINvsEsF1OoQbckTy0Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowAD3j8h4nEBq+V6qAw--.55335S2;
	Sun, 28 Jun 2026 12:00:57 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: PCI: pci_iov_remove_virtfn: fix unmatched
 pci_dev_put for PF device
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626155042.53862-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 12:00:46 +0800
Cc: stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <04CE07DC-95FD-4178-8D1F-07743D948D83@iscas.ac.cn>
References: <20260626155042.53862-1-vulab@iscas.ac.cn>
To: Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowAD3j8h4nEBq+V6qAw--.55335S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Gw45JryfWw17JFyDur4UArb_yoW8JryDpF
	WDJFW0krykGF1ktr47Zr45uFyavwsxX3s5Gan7G34xuws8Za4UJry5XFy5WrWSqrZ3Jr43
	JF1qga18J3W5ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4
	vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUcO6pDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwYMA2pAixEcCwABso



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 23:50=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> In pci_iov_remove_virtfn(), the function calls pci_dev_put(dev) on the =
PF
>  device at the end, but never acquired a reference to it via
>  pci_dev_get(). The function parameter dev is passed by the caller who
>  manages the reference. This unbalanced pci_dev_put causes a refcount
>  underflow, potentially leading to premature PF device release or
>  use-after-free.
>=20
> Remove the spurious pci_dev_put(dev) call.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/pci/iov.c | 1 -
> 1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 91ac4e37ecb9..24a4fb3cd042 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -426,7 +426,6 @@ void pci_iov_remove_virtfn(struct pci_dev *dev, =
int id)
>=20
> 	/* balance pci_get_domain_bus_and_slot() */
> 	pci_dev_put(virtfn);
> -	pci_dev_put(dev);
> }
>=20
> static ssize_t sriov_totalvfs_show(struct device *dev,
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang=

