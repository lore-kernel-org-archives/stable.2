Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAB9377ED9;
	Sat, 13 Jun 2026 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781355512; cv=pass; b=Eddvbn99jnkidfW/1u2ZMW47KYTDK4XKsROdS2iJaAXilAVmQqQGQr4EjAm9UtKVp47jXXxBINarmjqw72ofW9b7TB3BpvzeX77olCr/z0dN6akgrYQetgdpi99K3tbNQbQA/QgbpH+XJDMAp3v/m8Gmz68TPAODbCeYVTeMT2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781355512; c=relaxed/simple;
	bh=68KGUyBjo+fzLshBhbAwE3/fouemAtBaudDx6jPTuzA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OziynPFTcdBBVjJBuw/qzBhFkz0naiMsr6rHS+v5RiwDA9YbXXC2vzRZ7H1vknlybBukuQwPkqfPCtWfOIRKc17nXKx0mnO1zZEoyfVE9KiS2zuw7Ouz6aSdcIgtpc+v1An2UNOPbzMR5QFVxnbeltqNvDN6o7aA+OsQ7P05ts0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=UNQpPJN9; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="UNQpPJN9"
Received: from [192.168.1.196] (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4gcxJP37bcz49Q4q;
	Sat, 13 Jun 2026 15:58:13 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1781355497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=c3ls4ECWuCoS9r4NamQm+xC5GAqMUHvmtN0e218XRNg=;
	b=UNQpPJN9txIAkS1HT7z1bTp9Rp9Itx1kPGRh6x+8XyKH6Eb2n+0hhjZJkUiBzwPFFxu0QE
	XDPxYzi0xtpmzofz5kLTafb99v1/UPOK5Namn6Za5fWMQogd2W8sLUpeDIDnaW5GghwLay
	1VlR1LT4xhO5stihpEREQzJL+XWSJ2+L+I1FgKai47KX4ZCQOpYDH1EbClIsV9bt07nLmZ
	5yzAe8994gvLqBqeHWYte83Z2XZuCU4i7bD+M0oEnLs+WaEJouHh217nSQh0lxORZX1KIE
	gQi0hGaTDefxRT/vm2xzB2AmzIEPbLrgEWNLPaWP99nYY3at2RVIeOk+Y2r93Q==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1781355497;
	b=Wo22xLSOhfFL43hWbaKOmf9o/yTNFJ/DSn7be35IE1elF4AQqaTsU6ES9FAY/kj4lgxPyd
	/NzxkLZMymIXVTFWCIjTbU0DWgkNQBKP9WfJ3AZrKmd649SDjNhtUauphQz4rsqcaQzYsi
	ED47MISEmWw6QyW2ESxcN3VaDAn5J46mYhnilQTM5gNGxA3evxeFmAoFcgMeuZ9C+JdiJe
	A+xOGF0QlVz5VJLcEhS4rYw3MGPPOKae2kRR0uc5ww6/fahu9zG9ydJWTac7BE4P1FaU45
	HWyS44+ga1D2JZWnEYInlFtPFnzZI28oYHqe3anE1aPu0Cu3UjZMkw8FqJ+koA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1781355497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=c3ls4ECWuCoS9r4NamQm+xC5GAqMUHvmtN0e218XRNg=;
	b=ny/vXsXFuQyuiViFzynozNVbKI5lCSOIqOq7A122OCsH119e89RknR275vE8iJJxeMaPLo
	0NjmWCp9pDPt/pq4P/1+P0BDKAaNGWTvvS9ahdLGHm0NjEDZJKYFSpOONUUCIdAW6xKp9b
	V2H0NyCzvEAU/rUgv2wKMxsCAXqt72aeZ4Zy5rPHons1tYW04JhGSaALiL5fAiA2j8hn+R
	XHMzycMvXcngEN4py6glMhZ4Kbh4sZ49TpTo2WQNU7J4egcNtOn7hqNBlM+hQHqj+EZ8li
	ikSeK1ACDZ5brJd9rUfeXVr/nBQxeCM/u48HLuHeZV95wYXfg8jW0n1KiMCINw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <07e0a28650773abec711ee492fdb1bf5d21a6c98.camel@iki.fi>
Subject: [REGRESSION] Bluetooth: hci_uart: fix UAFs and race conditions in
 close and init paths
From: Pauli Virtanen <pav@iki.fi>
To: patchwork-bot+bluetooth@kernel.org, w15303746062 <w15303746062@163.com>
Cc: luiz.dentz@gmail.com, pmenzel@molgen.mpg.de, marcel@holtmann.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, 25181214217@stu.xidian.edu.cn
Date: Sat, 13 Jun 2026 15:58:11 +0300
In-Reply-To: <177920280488.2756414.8251481561878776667.git-patchwork-notify@kernel.org>
References: <20260518024949.439299-1-w15303746062@163.com>
	 <177920280488.2756414.8251481561878776667.git-patchwork-notify@kernel.org>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=mQINBGX+qmEBEACt7O4iYRbX80B2OV+LbX06Mj1Wd67SVWwq2sAlI+6fK1YWbFu5jOWFy
 ShFCRGmwyzNvkVpK7cu/XOOhwt2URcy6DY3zhmd5gChz/t/NDHGBTezCh8rSO9DsIl1w9nNEbghUl
 cYmEvIhQjHH3vv2HCOKxSZES/6NXkskByXtkPVP8prHPNl1FHIO0JVVL7/psmWFP/eeB66eAcwIgd
 aUeWsA9+/AwcjqJV2pa1kblWjfZZw4TxrBgCB72dC7FAYs94ebUmNg3dyv8PQq63EnC8TAUTyph+M
 cnQiCPz6chp7XHVQdeaxSfcCEsOJaHlS+CtdUHiGYxN4mewPm5JwM1C7PW6QBPIpx6XFvtvMfG+Ny
 +AZ/jZtXxHmrGEJ5sz5YfqucDV8bMcNgnbFzFWxvVklafpP80O/4VkEZ8Og09kvDBdB6MAhr71b3O
 n+dE0S83rEiJs4v64/CG8FQ8B9K2p9HE55Iu3AyovR6jKajAi/iMKR/x4KoSq9Jgj9ZI3g86voWxM
 4735WC8h7vnhFSA8qKRhsbvlNlMplPjq0f9kVLg9cyNzRQBVrNcH6zGMhkMqbSvCTR5I1kY4SfU4f
 QqRF1Ai5f9Q9D8ExKb6fy7ct8aDUZ69Ms9N+XmqEL8C3+AAYod1XaXk9/hdTQ1Dhb51VPXAMWTICB
 dXi5z7be6KALQARAQABtCZQYXVsaSBWaXJ0YW5lbiA8cGF1bGkudmlydGFuZW5AaWtpLmZpPokCWg
 QTAQgARAIbAwUJEswDAAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBGrOSfUCZNEJOswAnOS
 aCbhLOrBPBQJl/qsDAhkBAAoJEOSaCbhLOrBPB/oP/1j6A7hlzheRhqcj+6sk+OgZZ+5eX7mBomyr
 76G+m/3RhPGlKbDxKTWtBZaIDKg2c0Q6yC1TegtxQ2EUD4kk7wKoHKj8dKbR29uS3OvURQR1guCo2
 /5kzQQVxQwhIoMdHJYF0aYNQgdA+ZJL09lDz+JC89xvup3spxbKYc9Iq6vxVLbVbjF9Uv/ncAC4Bs
 g1MQoMowhKsxwN5VlUdjqPZ6uGebZyC+gX6YWUHpPWcHQ1TxCD8TtqTbFU3Ltd3AYl7d8ygMNBEe3
 T7DV2GjBI06Xqdhydhz2G5bWPM0JSodNDE/m6MrmoKSEG0xTNkH2w3TWWD4o1snte9406az0YOwkk
 xDq9LxEVoeg6POceQG9UdcsKiiAJQXu/I0iUprkybRUkUj+3oTJQECcdfL1QtkuJBh+IParSF14/j
 Xojwnf7tE5rm7QvMWWSiSRewro1vaXjgGyhKNyJ+HCCgp5mw+ch7KaDHtg0fG48yJgKNpjkzGWfLQ
 BNXqtd8VYn1mCM3YM7qdtf9bsgjQqpvFiAh7jYGrhYr7geRjary1hTc8WwrxAxaxGvo4xZ1XYps3u
 ayy5dGHdiddk5KJ4iMTLSLH3Rucl19966COQeCwDvFMjkNZx5ExHshWCV5W7+xX/2nIkKUfwXRKfK
 dsVTL03FG0YvY/8A98EMbvlf4TnpyyaytBtQYXVsaSBWaXJ0YW5lbiA8cGF2QGlraS5maT6JAlcEE
 wEIAEEWIQRqzkn1AmTRCTrMAJzkmgm4SzqwTwUCZf6qYQIbAwUJEswDAAULCQgHAgIiAgYVCgkICw
 IEFgIDAQIeBwIXgAAKCRDkmgm4SzqwTxYZD/9hfC+CaihOESMcTKHoK9JLkO34YC0t8u3JAyetIz3
 Z9ek42FU8fpf58vbpKUIR6POdiANmKLjeBlT0D3mHW2ta90O1s711NlA1yaaoUw7s4RJb09W2Votb
 G02pDu2qhupD1GNpufArm3mOcYDJt0Rhh9DkTR2WQ9SzfnfzapjxmRQtMzkrH0GWX5OPv368IzfbJ
 S1fw79TXmRx/DqyHg+7/bvqeA3ZFCnuC/HQST72ncuQA9wFbrg3ZVOPAjqrjesEOFFL4RSaT0JasS
 XdcxCbAu9WNrHbtRZu2jo7n4UkQ7F133zKH4B0SD5IclLgK6Zc92gnHylGEPtOFpij/zCRdZw20VH
 xrPO4eI5Za4iRpnKhCbL85zHE0f8pDaBLD9L56UuTVdRvB6cKncL4T6JmTR6wbH+J+s4L3OLjsyx2
 LfEcVEh+xFsW87YQgVY7Mm1q+O94P2soUqjU3KslSxgbX5BghY2yDcDMNlfnZ3SdeRNbssgT28PAk
 5q9AmX/5YyNbexOCyYKZ9TLcAJJ1QLrHGoZaAIaR72K/kmVxy0oqdtAkvCQw4j2DCQDR0lQXsH2bl
 WTSfNIdSZd4pMxXHFF5iQbh+uReDc8rISNOFMAZcIMd+9jRNCbyGcoFiLa52yNGOLo7Im+CIlmZEt
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ti, 2026-05-19 kello 15:00 +0000, patchwork-bot+bluetooth@kernel.org
kirjoitti:
> Hello:
>=20
> This patch was applied to bluetooth/bluetooth-next.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>=20
> On Mon, 18 May 2026 10:49:49 +0800 you wrote:
> > From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> >=20
> > Vulnerabilities leading to Use-After-Free (UAF) and Null Pointer
> > Dereference (NPD) conditions were observed in the lifecycle management
> > of hci_uart.
> >=20
> > The primary issue arises because the workqueues (init_ready and
> > write_work) are only flushed/cancelled if the HCI_UART_PROTO_READY
> > flag is set during TTY close. If a hangup occurs before setup completes=
,
> > hci_uart_tty_close() skips the teardown of these workqueues and
> > proceeds to free the `hu` struct. When the scheduled work executes
> > later, it blindly dereferences the freed `hu` struct.
> >=20
> > [...]
>=20
> Here is the summary with links:
>   - [v9] Bluetooth: hci_uart: fix UAFs and race conditions in close and i=
nit paths
>     https://git.kernel.org/bluetooth/bluetooth-next/c/7db62a762f61
>=20
> You are awesome, thank you!

This patch (c1bb9336ae6b54a5f6a353c4bd4ed9a4307e429b upstream) appears
to cause a regression in the following test case,=C2=A0which does=C2=A0
btmgmt power off; btmgmt power on; in a loop.

At some point response to Reset command is not received, and the
(emulated) controller can no longer be powered on.

Found by noting that newer kernel versions fail automated testing.

Kernel built with the bluez tester config
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/tester.config

With c1bb9336ae6b54a5f6a353c4bd4ed9a4307e429b reverted, the power
off/on toggle continues indefinitely without errors.

Didn't investigate so far why precisely it starts failing.


$ cd bluez
$ git rev-parse HEAD
40f2e34b373944cf8142154881ce69f92c2be68d
$ make tools/test-runner emulator/btvirt
$ bash xtest.sh
...
hci0 Set Powered complete, settings: powered br/edr=20
hci0 Set Powered complete, settings: br/edr=20
hci0 Set Powered complete, settings: powered br/edr=20
hci0 Set Powered complete, settings: br/edr=20
Bluetooth: hci0: Opcode 0x0c03 failed: -110
Set Powered for hci0 failed with status 0x05 (Authentication Failed)
Set Powered for hci0 failed with status 0x05 (Authentication Failed)
Process 38 exited with status 0
reboot: Restarting system
reboot: machine restart
Set Powered for hci0 failed with status 0x05 (Authentication Failed)
Set Powered for hci0 failed with status 0x05 (Authentication Failed)
FAIL

----8<---- xtest.sh
#!/bin/sh

KERNEL=3D../linux/arch/x86_64/boot/bzImage

cat <<EOF > xtest-run.sh
for j in \$(seq 1 100); do
    ./tools/btmgmt power off 2>&1 | tee /tmp/test.log
    ./tools/btmgmt power on 2>&1 | tee -a /tmp/test.log
    if grep 'Authentication Failed' /tmp/test.log; then break; fi
done
EOF

./emulator/btvirt -s &
trap 'kill $(jobs -p)' EXIT

./tools/test-runner -k $KERNEL -u/tmp/bt-server-bredrle -- bash xtest-run.s=
h 2>&1 | tee xtest.log

if grep 'Authentication Failed' xtest.log; then
    echo "FAIL"
    exit 1
else
    echo "OK"
    exit 0
fi
----8<----

--=20
Pauli Virtanen
