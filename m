Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4284248DF;
	Wed, 15 Jul 2026 20:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784146704; cv=none; b=g91pmEcsZyxhlY2qN4oEsgmi9nb107C+qux6GG0Q2tbPZkpbB4MCt68aaRX6fSya6W7lPy+amDeKDpGjwCLGtfNN64PbURV+vB23r4MW+fBpNuIzt7L+EdjMqGW0dw+z0/tON3wkHBiayTJFuMSxpmiN/fkz8UmKdNwPe/T42ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784146704; c=relaxed/simple;
	bh=Vp/BD8ZiK+yMr8rZuxPlFDBKTPA06ojHcI0aSpNv3YA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o4WD0ZgHMRu5pAMf+kzkQv8bmZ9HCkx7sRp37qcNw6gYKGS8WAc/Ji8ZNljTEhXXJDCNyOmfR+v1c22V+ezxappueMO9DK42xtyGyvFIc6EcczGouoasIl1JfnlMaE9pTnNB3B6ZAv71yiHpPLdDXA18P5u4iva/2PZEFWoKvzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KR5kFD41; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KR5kFD41"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908771F00A3D;
	Wed, 15 Jul 2026 20:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784146703;
	bh=44hytKvrMFJzw09LY48FH8rJGBfVj8HUM+EE0PN7o/0=;
	h=From:Subject:Date:To:Cc;
	b=KR5kFD41VCzgq1ng4j7PlRTe2Y4T8OFz0uKlehDWdQrpNYqDdOD91B8hON8YgFeR3
	 Oic7VSlqj0O6ztz3213A0RS3BLt8iaWt1PdydiOuqRhRvTYiGgxCrYmkHfVgZRztPB
	 y0Doh9UOCt1yggWWliflgYxQQnmshIBSsR9ceH7Y460BbHqlSBAFOdwShApccCeAos
	 V8gdjEaaXpsifh7GKtBuw/ZSP+Jaxavwu4o49vleGXTjHbJwkFGKEXfJOucI1pnbn5
	 iZDUVlyKgkhVIlCLwtjbZT3ypl45Xad1KufHHGB8/lyVn1ulmmBP/6RK2j742yvlZ+
	 zFrcvy3eGXNMQ==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/3] ASoC: tas2562: Volume setting fixes
Date: Wed, 15 Jul 2026 21:18:08 +0100
Message-Id: <20260715-asoc-tas2562-put-retval-v1-0-97bf467c924e@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAADrV2oC/yXMwQqDMAyA4VeRnBeoGXW4Vxk7xDa6yFBpqgzEd
 183j9/h/3cwSSoG92qHJJuazlNBfakgvHgaBDUWAzlq3K32yDYHzGzkG8JlzZgkb/xG9jFepXV
 97AhKvSTp9fM/P56nbe1GCfm3g+P4AmxInGZ7AAAA
X-Change-ID: 20260715-asoc-tas2562-put-retval-a5dd3e90fdb2
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Sen Wang <sen@ti.com>, 
 Liam Girdwood <lgirdwood@gmail.com>
Cc: Haidar Lee <haidar.lee@adlinktech.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=863; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Vp/BD8ZiK+yMr8rZuxPlFDBKTPA06ojHcI0aSpNv3YA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqV+sK3BfybxM7JjCWEfGaLzV45qQ0MhGhcZe2B
 ARLpkdIPLCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCalfrCgAKCRAk1otyXVSH
 0ERzB/sGQjbSW0YV5gW8QjYGZzjZVHBz9wj1XzXZc0lEFqJ+m+ENNiNUKnEK5fvTDgcptEpmt1s
 f6PrSrPALC0jaCMbVsjQyuSv6miIDvasUKqw47bkSUG9ZpbmptMH6KXNE+5lo+X92RkVAAIbhrm
 I5xmiu62mFIJL9TIP39trC1w7TI/Ty+qijdZmY8+xEN+9Q4Blf9FKF38xLinbTYiyTF1YucpxoF
 BZfMMOAOx2O4UMEFo6QZZK6aPgfy13XX7QRQ5ocpROjqzs9YWKh0BousZvf3oJPYBaIxrfYXlkc
 IZwqr6KdhDxgd7ZTZwzC6NDaAQ9ZNoLi1B9VTszPrjqLU6Tt
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

While reviewing another fix for the tas2562 volume control I noticed a
few issues with the put() operation, this series fixes them.

It's also a bit weird that the volume control is defined with twice as
many values as can actually be set, probably the best fix there is to
regnerate the table of volume values with the intermediate values.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (3):
      ASoC: tas2562: Validate values for volume writes
      ASoC: tas2562: Fix event generation for volume control
      ASoC: tas2562: Fix default digital volume

 sound/soc/codecs/tas2562.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)
---
base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
change-id: 20260715-asoc-tas2562-put-retval-a5dd3e90fdb2

Best regards,
--  
Mark Brown <broonie@kernel.org>

