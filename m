Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9184A2E2D;
	Tue, 21 Jul 2026 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784645309; cv=none; b=HsY6S6gnDYFq1KX5RSNrmrjJxM9V2KtQsEYvAIwh+A2yZKxWyHIT/2bh+/h6K3aMDsLNxICgaRdeYcyRQAAArrrWodCfRew2tRc87YYMDRrj3tJ4joWUQxNJYwTTwt+POyEsgfC2VfI8dSZhV61LO4tAsXgqy8Oq0dkuVo8oqFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784645309; c=relaxed/simple;
	bh=M6PUUG9um/n1vJEIfyj77W2zsTnAQYi3uaxcpP5nfWA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=P/Y+E+STn0SjkMvY5I0vrBtJoYpa1WplIjSz3/UOfox9SN68SOJHySRgb0LPhySmvMaZrerZ0b2152A8CAZqi8L4pu59U3FN6J5t12W9iIjQTCj7G8MOhqRl3w0kCg8INgwaQk69vbvwrFb5LBRrwBuNqlhPvZ+hMmKEaDwEig4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.97.49.238])
	by mtasvr (Coremail) with SMTP id _____wDXZTWqhl9qe+AjAA--.61812S3;
	Tue, 21 Jul 2026 22:48:11 +0800 (CST)
Received: from smtpclient.apple (unknown [10.97.49.238])
	by mail-app3 (Coremail) with SMTP id zS_KCgBnf3Gphl9q0ONoAw--.53334S2;
	Tue, 21 Jul 2026 22:48:09 +0800 (CST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] usb: typec: ucsi: acpi: Fix use-after-free of ucsi on
 remove
From: Fan Wu <12321260@zju.edu.cn>
In-Reply-To: <al8thH8aWmMOUuAZ@kuha>
Date: Tue, 21 Jul 2026 22:47:59 +0800
Cc: Fan Wu <fanwu01@zju.edu.cn>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F4203724-2CD7-446A-B766-79015B8E37B2@zju.edu.cn>
References: <20260718021142.3146566-1-fanwu01@zju.edu.cn>
 <al8thH8aWmMOUuAZ@kuha>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
X-Mailer: Apple Mail (2.3774.600.62)
X-CM-TRANSID:zS_KCgBnf3Gphl9q0ONoAw--.53334S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?e5QFjgXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WN0Q2EU//07hLCuQFu1C4kxAHgw0980SEoSzNLBCaa4RYmd
	4elvWv+U/t0OrYkVm5qp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7Ary3Xr18JF45WF4xXr1DurX_yoW8GF1fpa
	y3K34fArWUGF4Sga9xZF4fCFy7ur97Jr4jkr15J345Aws8GF9a9rs7K3y5uFyxZrs5ua1Y
	qw45Zw4xuayjywcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
	JbIYCTnIWIevJa73UjIFyTuYvjxU2LIDUUUUU



> On Jul 21, 2026, at 16:27, Heikki Krogerus =
<heikki.krogerus@linux.intel.com> wrote:
>=20
>=20
> I don't think this is enough. You now create a window where the ucsi
> is unregistered, but you can still call ucsi_notify_common(),
> ucsi_connector_change(), etc. So you'll end up with even more =
problems.
>=20
> If I understood correctly the long explanation (I'm guessing generated
> by gpt-5.6), the problem is that ucsi_unregister() disables the
> notification, but it does not flush them. My proposal is that you fix
> that by setting the ua->ucsi to NULL after calling ucsi_unregister()
> and then always check it in ucsi_acpi_notify(). You probable also need
> a lock for that.
>=20
> thanks,
>=20
> --=20
> heikki

Thank you, you are right. The proposed reordering does not protect the
connector state freed by ucsi_unregister(), while the notify handler can
still enter ucsi_notify_common() and ucsi_connector_change().

I also see that simply serializing the handler with ucsi_unregister()
could prevent pending command completions needed by work being cancelled
there. Thus, a driver-local reorder or NULL check alone is not =
sufficient.

I will drop this patch and investigate the appropriate synchronization
scheme. Do you have a preferred direction: should this be handled by a
core-UCSI quiesce interface, or by a transport-side locking protocol?

thanks,
Fan=

