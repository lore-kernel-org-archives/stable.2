Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795782284;
	b=3luWHdxbVe7QWMLvqTb89H7/Og175v0zXJ6DFv2Ve3dsvxgrcJ7U3f4WlQChOccdVQc7
	 w+J/y+BxputW3qP3Ru/VMxO3L6ofIF4ZIvjp7CxcFjB3hj9PAG2R4VqVes3wwtfpv2VCF
	 g7QMGAXI4GiQhQqa/FJ9znSBj0k8KWKX6YhvxSZqpfzFD389GHY7/v8jZ7z838JkArTv+
	 GU3/zh6autu3dO3QTXlpcLrhSeb8OKLBHaG2qQlAFvTS37OWCfWJ/cgCAKDDSfs6M49bG
	 x/yhSwCsTtZz/RZckGsdwyGwB5ZKAqzX38FMn5i2V7mzLuMaUkTvwW6EgwDggFik8ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795782284;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=rO7Sh9Nwb089btROzycFmyyXQeMnRKtY6cufHupqrJo=;
	b=m9fAJqp0Dw9UMxqjuUG0Z2UFF4vB7NsM1KBWn9wL6GFFMTjmbNlzHMgzJNPrHJJaQXQ8
	 aeysBT77RWo5JRn94oYPLfzksobrkIwtJiQ1f8TIQrjfO5dLfgJ7w+UXa8TsVOoPv89B1
	 Jmsndi/99dP9u5Jf3JTh7VXJdQjbQI5i5OD/Fwb7rxa354TZHmboUGnOE6Gcu1WsZFObX
	 /cSj4z3yWdLSOW1g/8MsECFRGyZXFKFj4lGrfkQqQBTFK32vRh8ZH2NQ7SikiFQRvcDL6
	 dJV63NqvV2mC7TObxaBcsvaZJrIIz+zlh5ws9AW2doU6LTwXWWeNbLLdNU+apk/o4tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=STe9x2iW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D74C606A31F;
	Fri, 27 Nov 2026 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=STe9x2iW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B0F1F00897;
	Fri, 27 Nov 2026 12:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795782283;
	bh=rO7Sh9Nwb089btROzycFmyyXQeMnRKtY6cufHupqrJo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=STe9x2iWOACvB+dvu+Cu3B7IGRYtpvofxEWZMvZV2FF3GzQ5CHK2uwRGRfdZjv4OA
	 xs0PIG9Jp76jGf4KERgqY0uE+WKpOlMGeJPF+j7WYGX6dTw2Z/bcom5CgC0EvpLKeM
	 UPTwBkuK6lKtGj54oZgT10alF9JEWhHRXL7KvCLJ1wJuUI6yT710nm7atbcRPk4B4q
	 veWirquSo1O+1DRSONtsJtNLGvDMV0SQYTeiltACd1YY+yPP7pEj/NjnuBu/WDO4+d
	 ScsC6439ejO6sGx07FNmDNfq69I8uHYFCV1xwbOk6lkSIVxG+Ks3keF5S+yE70xVs9
	 1h7eXJU4oW2+w==
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
Subject: Re: [PATCH] phy: hisilicon: fix UTMI reset leaks in INNO USB2 PHY
From: Manivannan Sadhasivam <mani@kernel.org>
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Pengcheng Li <lpc.li@hisilicon.com>, 
 Jiancheng Xue <xuejiancheng@hisilicon.com>, 
 Shawn Guo <shawn.guo@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, yana06070@163.com
In-Reply-To: <20261111085942.159625-1-yanxia@cmss.chinamobile.com>
References: <20261111085942.159625-1-yanxia@cmss.chinamobile.com>
Date: Fri, 27 Nov 2026 17:54:34 +0530
Message-Id: <179578227492.13164.6236523920077624562.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=969; i=mani@kernel.org;
 h=from:subject:message-id; bh=+STIkYRXLCv5THBHdorJX8rgjNT3hXEWJxeBya+QsqU=;
 b=kA0DAAoBVZ8R5v6RzvUByyZiAGsJdoWhugC4bbe9SHBil0DqtCM4wqjomPLeYum8iu90MTeaq
 4kBMwQAAQoAHRYhBGelQyqBSMvYpFgnl1WfEeb+kc71BQJrCXaFAAoJEFWfEeb+kc71rYIH/11T
 yEn3uKdwP6sBo9+AHgmy75BcWCVtq++YOXhfJUSIRnBhpjRjUs+11OSp3p7CINmj9g6unsqrk2L
 PLEB7RssR35FYv/Ol3qlJ3eTGdsMUJCMdOCuqZe2QSJ+UZZaxtPmmjf/toDnR1t87Lira9O/i5t
 BfDWtmy1Lua14bS/vnK6MYJOuh9NIjXb85ET+3Z+o1YrO39vNXa99vWrZpqT8U97/ftmRQkcpHG
 R95BEjsLSqvsR0Hdj0Z/V9j7mgDHqRMOmZzsrBMYbLMbeQ0uQWjF4+yk7YxaQ0Qkxzv7Xmi87vr
 pQSC95PUHjBpDh00hRUQVumISKzGyR/AszAFUJE=
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-11-11 16:59 +0800, Xia Yan wrote:
> hisi_inno_phy_probe() acquires an exclusive UTMI reset control for each
> child node but never releases it on probe failure or driver detach.
> The leaked controls remain acquired, so a later probe can fail with
> -EBUSY when requesting the same resets.
> 
> Register a devres action after each successful lookup to release the
> control on probe failure and detach.
> 
> Found during source review of reset-control lifetimes.
> 
> Build-tested the driver object on x86_64 with W=1 and reset support
> enabled. No hardware testing.
> 
> Fixes: ba8b0ee81fbb ("phy: add inno-usb2-phy driver for hi3798cv200 SoC")
> Cc: stable@vger.kernel.org # needs of_node_put(child) on <= 6.6

This is not a critical fix to backport. Please drop the tag.

> Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>

With tag dropped,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani


