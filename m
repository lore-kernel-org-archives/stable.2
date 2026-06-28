Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316FD17BA6;
	Sun, 28 Jun 2026 03:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782618757; cv=none; b=BVe22azCLreMCLF/7QpKZ+7G/DBMOuHrOeDyOOAHFpK06M4l2TctRPgBTYPGEZZr994H1K84JJhorcP2m4MQmJg7e7roV00Lnk2/gGwvroCW451xsiw/75H6XH4ZIlEGpNGGiF7qmKtdmYBcB1Zu7zfMaW58CHayIsVTovleLKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782618757; c=relaxed/simple;
	bh=p3/KyiAthvW4/bcjhcqg6SkQiX/i3QMq+dkCH8XhIzE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=u43NYj2ZQDswzz2IwUyD11TrUvnz6GLa/v18+xYrRo+5ds3r15ixTsD0Wwn2+7fTNFI1bQku8n9pry+fjq/GvMj67Os8IqstVjADPeD/HzkcRjObGdQhOWjGIu7bjZzDWpWhYNJarCOe1TS5SfPqPVQVd+HAdYR84P7bP/+qCLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowAA33NRbmkBqExKqAw--.34181S4;
	Sun, 28 Jun 2026 11:52:33 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: bluetooth: virtbt_probe: open_failed path calls
 hci_free_dev instead   of hci_unregister_dev
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626115019.33300-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 11:52:22 +0800
Cc: linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <44DA6935-B1FA-4961-82AB-A3DA692DE1C2@iscas.ac.cn>
References: <20260626115019.33300-1-vulab@iscas.ac.cn>
To: marcel@holtmann.org,
 luiz.dentz@gmail.com
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowAA33NRbmkBqExKqAw--.34181S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uw13JF4rtr4kKw1rXw4rAFb_yoW8Jw18pr
	s8CF90yFW7tF47JanrZa1UuFyjq3sIg3y0krZ0v3s09rs8trW8JryDZ3yUtF1xAr95KF47
	JF4kJ34xZws8uFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBqb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv
	6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw2
	8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
	x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrw
	CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8y5lUUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgIMA2pAhrYhJAAAsU



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 19:50=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> When virtbt_open_vdev fails after hci_register_dev succeeds, the
>  open_failed error path calls hci_free_dev, which only releases the
>  allocation reference. The Bluetooth subsystem still holds a =
registration
>  reference and keeps the device on hci_dev_list. Fix by calling
>  hci_unregister_dev first, then hci_free_dev, matching the pattern in
>  virtbt_remove.
>=20
> Cc: stable@vger.kernel.org
> Fixes: dc65b4b0f90a ("Bluetooth: virtio_bt: fix device removal")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/bluetooth/virtio_bt.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/bluetooth/virtio_bt.c =
b/drivers/bluetooth/virtio_bt.c
> index 140ab55c9fc5..bf6827431bb8 100644
> --- a/drivers/bluetooth/virtio_bt.c
> +++ b/drivers/bluetooth/virtio_bt.c
> @@ -397,6 +397,7 @@ static int virtbt_probe(struct virtio_device =
*vdev)
> 	return 0;
>=20
> open_failed:
> +	hci_unregister_dev(hdev);
> 	hci_free_dev(hdev);
> failed:
> 	vdev->config->del_vqs(vdev);
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang=

