Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F243259C82;
	Sat, 27 Jun 2026 11:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782561013; cv=none; b=Tc40Ah8W4SsJmhszeSIbDuXIUmLtkv+v740sjw308UfFcwz//45YcBCk76aZ8JABPs93NibwPNpcsquTYJRQ9ZuX1A/hzQsXAqc+O+N2ONp/ZMpFkDZhmZd6ulzbfFhsKdutSv9dZcbQ4uP/+JJ0sQ18UMRtZ13AyGlzckbEZQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782561013; c=relaxed/simple;
	bh=eUcSqBHkXirCMIOjpFOJWdsWV9uFVk8ox4QAtE6jOq0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jq/BENorviUON7gdpMcLdQ2WlJSW8YCzusxuF26kQhMkK1sn83UUfaRZyRGcxvqB90X8AUskgqSBXQnydqIwd+2xBYN1A3omqRkJYXMXf8J4C39OyRVecwUDX9w09b+UlwrysV3dHT0pjcpKH6twdkCBU4/OjNZvnBUAe3hOvr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [117.182.75.66])
	by APP-03 (Coremail) with SMTP id rQCowACXaZDpuD9qQjMMFg--.6005S2;
	Sat, 27 Jun 2026 19:50:01 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH v2] fix: net: renesas: rswitch_mii_register: fix double
 of_node_put after   of_mdiobus_register
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <fdb2120d-5d0e-445f-97a5-ef2307ebd4d1@lunn.ch>
Date: Sat, 27 Jun 2026 19:49:51 +0800
Cc: netdev@vger.kernel.org,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1846E0CF-B785-418B-A7D9-DD58D9C3B2F0@iscas.ac.cn>
References: <20260626152430.51835-1-vulab@iscas.ac.cn>
 <20260626152550.51911-1-vulab@iscas.ac.cn>
 <fdb2120d-5d0e-445f-97a5-ef2307ebd4d1@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:rQCowACXaZDpuD9qQjMMFg--.6005S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw47tFy3JFWUXFyxGr1xKrg_yoW5Ww4xpa
	95KwsIyrWDtr4xtws7ZF4UZa4v934ftayrGF1YgryIkFn8X34fKrWIg3yY9FyDW3s5ua42
	qrn5Xw1kW3WDZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkSb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
	1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvE
	x4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUgAsgUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwELA2o-mHs9ZAABsg



> 2026=E5=B9=B46=E6=9C=8827=E6=97=A5 00:10=EF=BC=8CAndrew Lunn =
<andrew@lunn.ch> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, Jun 26, 2026 at 11:25:50PM +0800, WenTao Liang wrote:
>> After of_mdiobus_register succeeds, the mdio_np reference ownership =
is
>>  transferred to the mii_bus device (released via fwnode_handle_put =
during
>>  mdiobus_release). The success path calls of_node_put(mdio_np) which,
>>  combined with the automatic release via bus teardown, results in a =
double
>>  put and refcount underflow.
>>=20
>> Move of_node_put so it is only called in the error path where
>>  of_mdiobus_register failed. On success, the bus driver manages the
>>  reference lifecycle.
>=20
> Please stop with these patches.
>=20
> First please read:
>=20
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>=20
> and
>=20
> https://docs.kernel.org/process/submitting-patches.html
>=20
> You are getting a lot of things wrong.=20
>=20
> * don=E2=80=99t repost your patches within one 24h period
> * Don't thread new versions of a patch to the old one
> * Include version history, how is v2 different to v1
> * When you see your own patch is broken, reply with NACK, and explain
>  what is wrong with it.
>=20
> Until you learn how to correctly submit patches, please only submit
> them one at a time, get it accepted, and move onto the next. Otherwise
> you are wasting peoples time, and getting yourself a bad reputation.
>=20
>     Andrew


Hi Andrew,

Thank you for your careful review and for pointing out this issue. You =
are
absolutely correct =E2=80=94 my previous analysis was flawed, and I =
appreciate you
taking the time to clarify.

Let me address your concerns:

1. On the double of_node_put():
   You are right. In the current error path, if mdiobus_register() =
succeeds
   and later macb_mii_probe() fails, the code jumps to =
err_out_unregister_bus,
   which calls mdiobus_unregister() and then mdiobus_free().
   - mdiobus_free() indeed releases the reference to the device node =
(via
     put_device()).
   - Adding an explicit of_node_put() in that same path would indeed =
result
     in a double decrement, which is incorrect and could lead to =
use-after-free
     or refcount underflow.

2. On the risk of untested patches:
   You are right to be cautious. I do not have access to the specific =
hardware
   to test this change, and I should have been more careful in reasoning =
about
   the reference counting semantics. I will refrain from submitting =
further
   patches in this area without proper testing or more thorough review =
of the
   existing code paths.

3. Proposed way forward:
   I will withdraw this patch for now. If I find a way to test it or =
gain more
   confidence through static analysis and documentation, I will resubmit =
with
   a clearer explanation and, ideally, test results.

Again, thank you for your diligence. I apologize for the noise and any =
extra
work this may have caused.

Please let me know if there is anything else I can clarify or help with.

Best regards,

WenTao Liang=

