Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702550;
	b=uavSGyKAoK31e/l59q41Mm0fShznUnBcCCOFEpu19th3uZ2xYCtU059OkvEhd2lnKQW7
	 eEGEDZeLpMuoM4HdGevjbWMxRPNu0d+JmT3o1LHAjQpBhPkHDm3yOogIZzYlA6598HgOY
	 kg27OlHmn1hh81z52caHhoEQCko+pyEYRV08gG0bx0/AWJbOyi14QsgcJnyD3ys65eM2K
	 2VA9U9l6EU00bSrKfo0t7L9rKNWTCCqBeQfV1XCUtXXJ3kwnbO+bYDA0u1tQtjQHyaZvh
	 wV0yIgh5Nl1AJ+ZEUu1d1B1S1n8MWec15G14yww1VKMt3FaePQfJp3e1DE1nqX0WieA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702550;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=wEEg6YZBK3MH8+pbJ9GFMoT9UlitmnXpR4fhPwenbkQ=;
	b=SHT9AdvCQDOwYCrEpe6QnYMCWVeKUe7VJdaRgKqEsMWqudsqLcH2ZQYKkiFQ30pCaDRH
	 MV4EoZJNp+h38+fQgg40K0Paj8QnObhEr1+7PE0bCO3l+l8cGPxej82gEP/Zt2IhbUZ6G
	 +gJ1sHo3zdj/9z5WlTcFiImFfmAay2xrKAGmRetY3Szi9uXUWQNsJ3mvTCwQjkGdY5b/Q
	 N2AteDqNb8tu1Vli6C4Do55EharIPy/HtXIswhgOIhg0+cp03SYyS3jkAWK8SMdBOzyQn
	 4986s4o/U1rLlQioL/5x8zpETGTeULgcVqI+pxOh6czK0aU+fB5K7Go/DkjKbLvp8uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DF6606D837;
	Tue,  3 Nov 2026 10:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47DF6606D837
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACXaZqTuulqdsg7AA--.64861S2;
	Tue, 03 Nov 2026 18:42:27 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] of: unittest: fix node reference leak in of_notify()
Date: Tue,  3 Nov 2026 10:42:36 +0000
Message-Id: <20261103104236.1373612-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:rQCowACXaZqTuulqdsg7AA--.64861S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr1DKFW8Xw4DJF43trWkZwb_yoWkXrgEgF
	yIvwn3WFWUCF48CwnxJrnxZF9FqF1Uur48uF12qwnIg3yjyFnrXrs09r1rAw15AayfCryD
	Kr4DWw1YkrnF9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j
	6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjfUrv
	38UUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAMAA2rpnOF62AAAsQ

of_notify() takes a reference on the overlay node passed to the
notifier, but drops it only for the unexpected action. Every regular
action returns with the reference still held, which keeps the overlay
node alive after the changeset has been removed and its memory freed.

Move the release out of the default branch so that it is performed on
all paths.

Fixes: 992b0dc5c38a ("of: overlay: unittest: add tests for overlay notifiers")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/of/unittest.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index a6ac58b4d883..47da90bc0d3b 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -3472,11 +3472,12 @@ static int of_notify(struct notifier_block *nb, unsigned long action,
 		break;
 
 	default:			/* should not happen */
-		of_node_put(nd->overlay);
 		ret = -EINVAL;
 		break;
 	}
 
+	of_node_put(nd->overlay);
+
 	if (ret)
 		return notifier_from_errno(ret);
 
-- 
2.34.1

