Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724572;
	b=J2yWd0y2npfzMJP+PKGq3VLIKJaD4eYivzO826u/rPrECbsYLbsm7xkG/UyfPJJN7qKb
	 tv2JqpjbcxG58zvfnkcaQIH+1ydsH7po+8wjJLPTPn8HaCynpHqeGpqfCduBeqDXKdXQf
	 PtqMS9BJBlCQJpMXAKGA9zf8BHGfYIU9+lAsjrIxRhQQQY15NsRrN+5nBABz5ubBL2/ML
	 59+loyk9NdB6pMo0LX0weU6GkSE65XEiRlfDkdt/PvTgh3qnhO13EU0eNhs0igk9YzWhQ
	 RiDcpWEsuI61HB+nLocVCb2ZAxwgUAylSSMzlFNonONkWmmXabgpDS7Uqg3TvyHgfeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724572;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=np7p/6NbTxeJslZosMV0zK5KJlcaQZxijqGp2JarPLU=;
	b=fPDRwOOur2W1bwB8s5TeLbOiuAMnZgosYwqfjkSOL2Bp8fRNgtcGi4hApf5OFFqT1K2x
	 YsedfXm/ffammtb3Jmkg62G49bH6Zq3h2drsYuhvIEZCcI7cGjdWKm1Y7X1jwla4GbbSx
	 0udl3pvaDnGSUukvvbEt69CJnH5hKYTyuDp7iz+ScNllDYLSGPN+Btiiag6SiBKcqNzcH
	 uN9poPQXcqyzxOUweFu5IZW49pVVqC1mTak4RIXJ4uc48z+idYfrSK1k0KbN5lmDM/DaG
	 ra1J81ZJ7k1c3Fz06XrAI7u+0m0h8IpGFn7wiHWlnHvzVAxX4ZB8wHp5TTrVbj59Jdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=o0UG9xjN;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D957A606D818
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 16:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D957A606D818
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=o0UG9xjN
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A62F21A143A;
	Tue,  3 Nov 2026 16:49:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7C5F96046C;
	Tue,  3 Nov 2026 16:49:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 87D67103291A7;
	Tue,  3 Nov 2026 17:49:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793724569; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=np7p/6NbTxeJslZosMV0zK5KJlcaQZxijqGp2JarPLU=;
	b=o0UG9xjNgeYBvqnjrJ/ZgHAa8ZNAl8VTBAtW3ZHiuLiXxWkPgyFX9NlzKkydGu+Ow68MOK
	zfOYRB25MlqyM7PjhsY2DQiREcTbTdYx3tOGOJMV0AQw7HTewiRigXN7baB4Dyt/EP5ID4
	7kEQmrt+FaYYJkeEIvdPsPPdJVUcfQtfDkPoifxcomib8v63AayFXAsSHs86QCnnH8OT5w
	fBPsWTXi1T8Cksn3gHsWm9R48/nDWBf7luicKuBYTSQzH5OWHXmBha/I6JGkzE0tPZx/+1
	Onabc7fZIWpJ3pguchXr/64O3552jsioBf2qPoyOlNI7wowS/8fYz5VnYkRzLA==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Tue, 03 Nov 2026 17:49:10 +0100
Subject: [PATCH v5 2/9] i2c: cgbc: Use real I2C bus names
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-cgbc-i2c-storage-devices-support-v5-2-ac11f23fae51@bootlin.com>
References: <20261103-cgbc-i2c-storage-devices-support-v5-0-ac11f23fae51@bootlin.com>
In-Reply-To: <20261103-cgbc-i2c-storage-devices-support-v5-0-ac11f23fae51@bootlin.com>
To: Lee Jones <lee@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

The adapter names described the expected purpose of the buses ("General
Purpose I2C adapter", "Power Management I2C adapter") on conga-sa7 board
rather than their actual names on the Board Controller.

Rename them to the real bus names "cgbc-i2c0" and "cgbc-ddc0", matching
the naming used by Congatec.

Cc: stable@vger.kernel.org
Fixes: 6894f640b8f3 ("i2c: Congatec Board Controller i2c bus driver")
Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
---
 drivers/i2c/busses/i2c-cgbc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cgbc.c b/drivers/i2c/busses/i2c-cgbc.c
index 9909c25f0b18..ac23435b731b 100644
--- a/drivers/i2c/busses/i2c-cgbc.c
+++ b/drivers/i2c/busses/i2c-cgbc.c
@@ -358,7 +358,7 @@ static struct i2c_algo_cgbc_data cgbc_i2c_algo_data[] = {
 static const struct i2c_adapter cgbc_i2c_adapter[] = {
 	{
 		.owner		= THIS_MODULE,
-		.name		= "Congatec General Purpose I2C adapter",
+		.name		= "cgbc-i2c0",
 		.class		= I2C_CLASS_DEPRECATED,
 		.algo		= &cgbc_i2c_algorithm,
 		.algo_data	= &cgbc_i2c_algo_data[0],
@@ -366,7 +366,7 @@ static const struct i2c_adapter cgbc_i2c_adapter[] = {
 	},
 	{
 		.owner		= THIS_MODULE,
-		.name		= "Congatec Power Management I2C adapter",
+		.name		= "cgbc-ddc0",
 		.class		= I2C_CLASS_DEPRECATED,
 		.algo		= &cgbc_i2c_algorithm,
 		.algo_data	= &cgbc_i2c_algo_data[1],

-- 
2.53.0

