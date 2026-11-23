Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795398518;
	b=hXMiGHQKpH8o8L1wAD0oQBIL4ae1KyliOeUrIlhhnIeche6B1K5MF0cFZN8EFvul1wEQ
	 YDGeytngtbDed/NU2zk7hBnu6cyoFjj0l3p/YMgnfsmgT9lniSvuN3Ustth6tVHNF1CBQ
	 BwJuzyDScFnIGQ1xfvJjJWNMw0wMhPE5PQ5kLspX5+cGVV4h4jF2IXEqVTUZMobDO+myb
	 IEQi2l3YMUM6/gYrKd+rkyRC2BLyae1NPD0qRNEG6TYXv2Eas0PCXFMRhcGwKrfetKYcN
	 LTDF5Xi8JRUGFNuKX+jv2yH9T1EOeBzmTSA877pTiDl/mUqRilBVSBXFVnd137Q4TSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795398518;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=FTzAjKQSHxlNRWgx/yZCGJcmPJ5L7IOVnJKBdJAxvyo=;
	b=szt6Nwy/bc2GoUJTQ0A0b5sX6rQ4fKj7BcxhBbJKutjR+a5JsF1Tfmb7R09kMNbqOpd8
	 fT/mvuYI+sSeeiwl++dYZ0jGTpFeCsNuhswgPI4JzhUA3kL8Mf//MwVG2eKMiomghTKoO
	 0LBb5gxBvK/P/UjLpGhAcXcOmzawrkcWeFT9lOI0Z1fYyB23zU2BA3Iu/c3oS05fEKy32
	 rus75i8OmML6y9jJy8ZTt7R/ntwXma1D5wxIoK+VnN1M0RCN/E5RCRHMCrKP/hHM9DSKA
	 3e5JJ3FRW7uwEAkwezwcLWfkbuN6A4dZM+qlL8S2AbJ6ct2wKyWK5UwODT+whxKX0rA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=boMEKDE9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C222606A31A;
	Mon, 23 Nov 2026 01:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=boMEKDE9
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795398518;
	b=sz77ZpcaU7uIMvuoOpNNEmhtXAi/iEr2BTyuBvG5+ZTKLusHOuTTv10OfTx39HFsvjBk
	 XEYwMRpnexnHkKw4ZP8qk5nir5nVxPHmRZ263pTR2q5tAC+vzFH5CJnD6/VOk0aOtziDW
	 k4LoE5QF7EW3OsB5BiBZez3tqlOgrh1boylaHZDVxMr7hosYAFt6LL6v4v7Fw8xUoNGAa
	 UCMxHaan8R81zQk49XapVnJyT7YlYl5WSB5BYfwAKWpks5/C1T8K7jaGGvtpZxAfJG/hR
	 zoYgdiDJTNV0YOCeCQKT3Xemo7HLcXYSItAVgDJy5GRxUxZDcT/52trn0AFz4JQ5oBA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795398518;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=FTzAjKQSHxlNRWgx/yZCGJcmPJ5L7IOVnJKBdJAxvyo=;
	b=z+w9sGwRVAEu1Qntm81CIEfDGDIfBWCQnEMPjrG3MKMwhZO1hQ5iWo+bnCnw5TO0f+8E
	 cAiQvsAyp4a9uud98+LZq6KLyLD5TNVpjfteZGTybj0WqnyLS4usnkDwyf7H701omBdQm
	 K8zwwmpMKtuxsF/PjEFOvWgXz/HSGL8noCrpEfdvFv7G23eMta05NkFOsfqm0tMzA7Eef
	 IacM9e9qoytf74OL/RYx9YJQYy6Xkjk4cl9IpmcYDaP3Qbdd2FY94M6iwmEfEkxtX8pB1
	 wEINPQP7fVB22YtPa+GfRbJnHaOyoUUU3ZyN5PM49DqZCXnbBe8Hb1ZhRmIW+0MBpEw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 563631F000C0;
	Mon, 23 Nov 2026 01:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795398518;
	bh=FTzAjKQSHxlNRWgx/yZCGJcmPJ5L7IOVnJKBdJAxvyo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=boMEKDE9Z3Iawjr0ynXF4I5RkuTN6jnv0f2Lj80ptB2iW5bfGkkEcsONAACUYNsrL
	 EJrQwZhRoe34622AzrBZET1KPbribLsMQR8DICQj+mhqykct5jw1FSUwV/mSt49u+e
	 TxC0nM6KdKb0P4UCqoU1oggdh/MBxUXfC/fG2cVArS15qlj8buEqY60a8PHssuUr3v
	 9pGzK76WgIm1JQaRndPtnSRk6mt8RO+f/DcXMOUmaqIN9ZgodjXdR8T8BTZT4E0lRi
	 xm+QtO0nQ8vmUmpLCr22NJKIoyPDr8w+7zBpLmaDEQJ7h8wCcpktzhkH37EOuB/sog
	 i3vavzBW5OoAQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CAAD14C2E0;
	Mon, 23 Nov 2026 01:48:36 +0000 (UTC)
From: Fabricio Akio via B4 Relay <devnull+fabricioakio.gmail.com@kernel.org>
Date: Sun, 22 Nov 2026 22:48:34 -0300
Subject: [PATCH v2 1/2] usb: gadget: u_serial: Publish the console only
 under port_lock
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
Message-Id: <20261122-u-serial-console-dequeue-v2-1-820f355827e6@gmail.com>
References: <20261122-u-serial-console-dequeue-v2-0-820f355827e6@gmail.com>
In-Reply-To: <20261122-u-serial-console-dequeue-v2-0-820f355827e6@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Neill Kapron <nkapron@google.com>
Cc: Krystian Kaniewski <krystianmkaniewski@gmail.com>, 
 Brian Ellis <brianellis@gotenna.com>, Ai Chao <aichao@kylinos.cn>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Prashanth K <prashanth.k@oss.qualcomm.com>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Fabricio Akio <fabricioakio@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795398515; l=1827;
 i=fabricioakio@gmail.com; s=20260928; h=from:subject:message-id;
 bh=bQFCDRqy5e6noIavX7zwxVbe546YTjkWtU7/BccXBn0=;
 b=ssdBs0Iy02dHW2KVUSBVWEgz/5+XUebgNuEDZbyhVBJiUefFtf0Ca0q7+w5UHASea6BwgTivd
 DwITeE8fg8QDKW+ep2b3EGAP+BhvIKaJrhds/GB1tzEJWgsITKq9AeP
X-Developer-Key: i=fabricioakio@gmail.com; a=ed25519;
 pk=TlMUT8bPI/ZQzp2q24BIQTb2qSx/jdUTBlGEXIRCm54=
X-Endpoint-Received: by B4 Relay for fabricioakio@gmail.com/20260928 with
 auth_id=1076
X-Original-From: Fabricio Akio <fabricioakio@gmail.com>
Reply-To: fabricioakio@gmail.com
Content-Transfer-Encoding: 7bit

From: Fabricio Akio <fabricioakio@gmail.com>

gserial_connect() and gserial_disconnect() find the console through
port->console under port_lock, but gs_console_init() sets it before
taking the lock, and gs_console_exit() clears it after dropping it.
A host connect while the console is being turned on through configfs
can then connect it twice, leaking the first request. While it is
being turned off, a connect can attach a request to the console being
freed and schedule its work after cancel_work_sync().

Set and clear port->console under port_lock, together with connecting
and disconnecting the console.

Fixes: d7cb8fb7aa7d ("usb: gadget: u_serial: allow more console gadget ports")
Cc: stable@vger.kernel.org
Signed-off-by: Fabricio Akio <fabricioakio@gmail.com>
---
 drivers/usb/gadget/function/u_serial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 0a304f508bc3..1f0110ea7f6a 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -1173,10 +1173,10 @@ static int gs_console_init(struct gs_port *port)
 		return err;
 	}
 
-	port->console = cons;
 	register_console(&cons->console);
 
 	spin_lock_irq(&port->port_lock);
+	port->console = cons;
 	if (port->port_usb)
 		gs_console_connect(port);
 	spin_unlock_irq(&port->port_lock);
@@ -1196,12 +1196,12 @@ static void gs_console_exit(struct gs_port *port)
 	spin_lock_irq(&port->port_lock);
 	if (cons->req)
 		gs_console_disconnect(port);
+	port->console = NULL;
 	spin_unlock_irq(&port->port_lock);
 
 	cancel_work_sync(&cons->work);
 	kfifo_free(&cons->buf);
 	kfree(cons);
-	port->console = NULL;
 }
 
 ssize_t gserial_set_console(unsigned char port_num, const char *page, size_t count)

-- 
2.56.1


