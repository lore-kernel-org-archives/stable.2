Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FCA39A7E1
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 03:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789703786; cv=none; b=cTIEaWk7iWNfMVUQG7Y1zhhuA6sf6/2uDnj9x1Fk7jo/EN05VklZqyJXUpfmHfGg1pGwJufyrf7qkFAqTEs8bKw6y+mXIkZw5DvvDy6P1k8PYco0g8ea5LQDnttIfOK7/lJaRurbdK1h9/SidSLW4xTaW08PDFheIIbRVPKt/64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789703786; c=relaxed/simple;
	bh=pkNHXt5gdQSHxwxTqenzPOdTbJOI7BzP6Y7cUui9JRk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dSjDlu3NZpvVLNbwQ+B28IXXl0XRfnn6vRM8JYdoCwn6Py67eSZeFfoiJMsyB7sQYi73FXh7QuuqC5WV9Qi7eirdP8TjNZ4kk+O2+874A4DUL4PsMFZLpVPbz6YBO5rZmYujZqsT/9XzPz6kZUbr8H/69xXM4/BpsjgUDjs7zkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpsz20t1789703772t7637d381
X-QQ-Originating-IP: 2w5xdtdlO4Bev8ojz+MFY/d6nb+kMkzlVODl9mwoWCA=
Received: from smtpclient.apple ( [125.118.25.28])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 18 Sep 2026 11:56:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3536635797696143373
EX-QQ-RecipientCnt: 14
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net 2/2] net: ngbe: clear DRV_LOAD bit when ngbe_open()
 fails
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20260917090050.1927999-3-zhangyunfei1@kylinos.cn>
Date: Fri, 18 Sep 2026 11:55:59 +0800
Cc: netdev@vger.kernel.org,
 jiawenwu@trustnetic.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 aleksandr.loktionov@intel.com,
 leitao@debian.org,
 weirongguang@kylinos.cn,
 u.kleine-koenig@baylibre.com,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9D109671-17F9-4BA3-8814-534E238FA0E2@net-swift.com>
References: <20260917090050.1927999-1-zhangyunfei1@kylinos.cn>
 <20260917090050.1927999-3-zhangyunfei1@kylinos.cn>
To: Zhang Yunfei <zhangyunfei1@kylinos.cn>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MuYPkxQe3jgCQbjeRlFX2cNRykAWePd9yRxtjkXfSuDPxW6BGTnYWCxZ
	dZg/VFmQccL2PrEb4jTQqSI23o1U9/RTV+D4x9zNjsVJihXsihxAjEk64ZyEEhErQqYVV5V
	cBv+BxBSkEwb/uCDUz4zt7vj9liBNUrYrWTKXwuslVHmgLSRC2k1s9SBeAWXbLUG1yXv2nj
	gBWjxZpKafyUTqYdy7M7WncrYT/40Dv1hXvhkRusmQOco6KTFC45Q/rjR4ZuqMbU0euToqN
	MSssbqMf66SeG5BbD9FYw8RqpRui0JwDR7a6toImfakLUaUWvn3rKIUXLEaP6W8B8znDUaR
	gtuvMGJvpeSHj5sHdsMlJeUpjhOudUdYV/e4NKkHmbtx+SapG/YpHURlEHc0cwCwk7W8kJL
	4SkelGg00jYMCOsRaZLDY+nl7m5JT3NqzFHG2Fcr9thzWm0pRdkZSVFyRVC1M83wZtXYYIe
	/pvhYjcxZjloa4F9X2QdJFYVFIWEWX1kXiCJ2ZwHf6PPZZc8RAjU6jadzZ6hKSe+Hfo6U2F
	/cnim+IOa4rgG/9rH+nBehYXkrWqW3iVJgQam/uxLP44RJ2rILhv0KF2euBr/FEjs2OIgty
	xHaLfhcn7oYa7jm754xO3FPL5etmpq1hqU/RVduqHd/GN1l/afTmQ6Nw0dixMfUMuSg1O6X
	lOPcrrdFoX1By9tjn6mYhb/u/WQUjyZvkbrbPdagNTpRdlxgV+UnPZqT8dxt7YeYyY87P/z
	3xA1p0d0NoPFiwQHRJTd/z9zBLXQmzSB72aMVXqoKbFLQ+ra0byJhAWVffw3cyvkbS2pC29
	ZCayq2sPNoFrFq4R2t2C7JgmRufzs0a6o5OW2H+avJkt7LMIg88HRBedtPapmQifKndykk1
	JwrIkWCPlzUmDuSAbwzYFUjfwU7pcW3D+1NX+n6+gWdZJsTGe9Jw5dRo9IV3LjQAcau48+4
	wy3I+lqgTVrtuRb70OVD9QGGzUUY5NbMhUpU+dyAX01z9nBxYk0Lar9hGBSkwvLxduaG26u
	D4sFgscVetPZpPjWT/ESob1FD7xB+bj5cQvWf28+98xR2/nZLPZyzgTRvVcA7VZm3XnHL3f
	WCCxfx6/7mO
X-QQ-XMRINFO: NI4Ajvh11aEjRFH9cCmhAbSrxRZSSeBQhw==
X-QQ-RECHKSPAM: 0



> 2026=E5=B9=B49=E6=9C=8817=E6=97=A5 17:00=EF=BC=8CZhang Yunfei =
<zhangyunfei1@kylinos.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> ngbe_open() sets the WX_CFG_PORT_CTL_DRV_LOAD bit via
> wx_control_hw(wx, true) to tell the management firmware that the
> host driver has taken over the port (NCSI/OOB firmware stops using
> its management channel). Every error path of ngbe_open() returns
> without clearing it, leaving rings, IRQs and the PHY torn down
> while the firmware still believes the host owns the port, an
> inconsistent driver-firmware handshake state that persists until
> the next successful ifup.
>=20
> Roll the bit back on all open error paths, matching ngbe_close()
> and ngbe_dev_shutdown(), which already clear it.
>=20
> Fixes: e7956139a6cf ("net: ngbe: Add irqs request flow")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhang Yunfei <zhangyunfei1@kylinos.cn>

Reviewed-by: Mengyuan Lou <mengyuanlou@net-swift.com>

> ---
> drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c =
b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index 6d8289e2532d..88f00b72a512 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -494,7 +494,7 @@ static int ngbe_open(struct net_device *netdev)
>=20
> err =3D wx_setup_resources(wx);
> if (err)
> - return err;
> + goto err_control_hw;
>=20
> wx_configure(wx);
>=20
> @@ -526,6 +526,8 @@ static int ngbe_open(struct net_device *netdev)
> err_free_resources:
> wx_free_isb_resources(wx);
> wx_free_resources(wx);
> +err_control_hw:
> + wx_control_hw(wx, false);
> return err;
> }
>=20
> --=20
> 2.25.1
>=20
>=20

