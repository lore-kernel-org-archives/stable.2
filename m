Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121439;
	b=KjgHYZpL/KGr7rpVmza1lgzWtUGeNpewY5hHfzPP8Sg8VuhPi/hA/unhVAAurq9gtN0l
	 yuFoSarkoApD/lsUsmmT44cXNiHDlU7McEAsbhnJjdRzoym+hfs9+NS8pVWDZJLV6v+PZ
	 NkRY7SSN4NAslSSNuwTngvIlOC0mTpOXitDu5T+VAVx1vClCnzESRFs/EqQDlPSwvxkat
	 oq7Ox64Pl3wQfG+c8RY9jwa/rFzqmFqMlrKv6+ndW+4dLV54OqHB2h1SO8tISf6m9P/Xb
	 B9L2Ic3xWfs2aGRBbH994ohy/6y4auvzC+ZRaLIoML+cE0LtY0cjNUnV2wmxAhjmdxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121439;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pgdtqChxS/6Gzw+/Chi3si2+lQ114SNwivuAZLc2ooE=;
	b=OHoIfPHqrS7wi8S6RxP9zoztDmjPMUOby6IEiI3erFYH4cc/bKMBey/JxV21QJstHcwb
	 0FVSiOA0wGTKSlOOCn5gvZSphM8jrojN4fCTj2mYwpORZKAWHJNSczCN159Sv7uwCqVI2
	 vaHaeNPl07HbYcWorYQMrihm1Bz7uPpgNQQfI30ozLi7xXHRjnD9klvhgDITWYLO39EYd
	 U7hp5xo3oY9EsaKr9xOuSxm6h3f05NMDBiKqH8EOmwMTNwgEXhMTDeSkaxvWjBiQPm/Mz
	 IbHMyWTcRpw9lIXvDU/7ApfPEa0GkG6aWXfXMfXlpKBdRR6AjUkCYvZVQnBFECMqQJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FP+rIsy+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADA2606A904;
	Thu, 19 Nov 2026 20:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FP+rIsy+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1D41F000CF;
	Thu, 19 Nov 2026 20:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121438;
	bh=pgdtqChxS/6Gzw+/Chi3si2+lQ114SNwivuAZLc2ooE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FP+rIsy+3dmIp0iEbCmVGWcSC8n9qkS4YQVT1wuluuRISz0UpvolTRxDljRoVsHoN
	 146J1r2++i3f8/25DBDDo5khOlcNMqSkC0Xy/a/3TcLDpZ6pL5ZC6Nt3kzfDuF3sKq
	 ce5loTCd82CaYmojhcit4YAkBUi/nRv/Ts4MTUEYc4UVB9WQBNH2nHRDPQ869uJ+cB
	 aYcuU7/hEKN7yelKP/8mlIeRZ7DBZ5mnwHepofn+yUiEX0ZE9o8Z/9I83HRb+AFsNI
	 9lF1gKeOAaSdRmc8g135rKPi7LciPOEQ0TIw5+AG+ik8Qj7U/b9IfRN0Tj9CKQjlq3
	 cXaKIIXdx407Q==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 03/12] pinctrl: nuvoton: ma35: Retain child firmware node reference in ma35_pinctrl_get_soc_data()
Date: Thu, 19 Nov 2026 20:48:59 +0000
Message-ID: <20261119205013.2563811-4-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261119205013.2563811-1-lee@kernel.org>
References: <20261119205013.2563811-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

for_each_gpiochip_node() drops its reference on each child firmware node
as the loop advances.  Storing child directly in bank->fwnode without
acquiring a reference leaves bank->fwnode dangling once the iteration
moves on, leading to a use-after-free when ma35_gpiolib_register()
accesses bank->fwnode.

Acquire a reference on child with fwnode_handle_get() and register a
devres action to release it on probe failure or device teardown.

Fixes: f805e356313b ("pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO driver")
Closes: https://sashiko.dev/#/bug/linux-f140abe2-145a-4f6b-b626-bbabdc7327c4
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2: New patch, retaining a reference on bank->fwnode (Sashiko)

 drivers/pinctrl/nuvoton/pinctrl-ma35.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-ma35.c b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
index aff2212c6278..c9e09c14a101 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-ma35.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
@@ -556,6 +556,11 @@ static int ma35_gpiolib_register(struct platform_device *pdev, struct ma35_pinct
 	return 0;
 }
 
+static void ma35_bank_fwnode_release(void *data)
+{
+	fwnode_handle_put(data);
+}
+
 static void ma35_bank_iounmap(void *data)
 {
 	struct ma35_pin_bank *bank = data;
@@ -629,7 +634,14 @@ static int ma35_pinctrl_get_soc_data(struct ma35_pinctrl *pctl, struct platform_
 			return -EINVAL;
 		}
 		bank = &ctrl->pin_banks[id];
-		bank->fwnode = child;
+		bank->fwnode = fwnode_handle_get(child);
+		ret = devm_add_action_or_reset(&pdev->dev,
+					       ma35_bank_fwnode_release,
+					       bank->fwnode);
+		if (ret) {
+			fwnode_handle_put(child);
+			return ret;
+		}
 		bank->regmap = pctl->regmap;
 		bank->dev = &pdev->dev;
 		ret = ma35_get_bank_data(bank);
-- 
2.56.1.750.gf70dc682cf-goog

