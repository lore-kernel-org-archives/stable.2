Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792513731;
	b=B97zKMkmLWWE+HTSLgcko2jmkRwVkV7gfghcaM83dElPvkjVy9fBSaOTE+HJLdm4gxnH
	 hucVDyIN4qyPjfRhOWex/3Xg/4buujQm+lJIkAzB2wGVh/3UP+PZP2wUwTj1J/oO00GSw
	 cK50XG7kYu4g0/9ec8aykt9aYQICvHMq2J7DvR907Biobo8ZzmSiJ71w8d+JCjBIz8jUm
	 crA+ghKqGPLhPZNX7hvIcgorLRua8j2y9auHk9IVuhU3f/ZnIO/B6IfN7O2N/PMsHpizr
	 aLgfC8pq+FKSzDAuiB7AUAIZNOJtK4G7h18huCTLj+1/VkSmLPK3iLfj7ZR9jv+ea9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513731;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8GCq0bTVh4yie0TWDWgdrW8f3IBBSZUxdZvQWHXs5MM=;
	b=wyEALPK26Q7qtaKOj/6dCHbezlGy+l3ax4Jc3XeoXPGx2iua6n7IbGwOBxJjqzzM3Hqi
	 4sCc6JQLytePoE9gmTW2AIdxODmpYUnw/mRPHkQj6wZsuEBYzbMUwMNiUaUnK/oD0GrJ2
	 rCJUFaRejXYEX5iI7zk/RF+BQIsuIqaUo56rFWLbTrSbyzrsPB8eqCqMkwpI+JgfC0uxs
	 fDaRUM4dXEx8rHrqqc8d/ox6VeamXmu683+EsSIlj+t/VjPugU7uVbEw936JVa4m3Q0DQ
	 ia5syuB0LB2j4N4kQemYz0oiQAFWLgQB16YS9JhwnZxUoD01VYpBF3gBeLnYDT3XRKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JxlVKwB+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B495B606A31C;
	Tue, 20 Oct 2026 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JxlVKwB+
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792513730;
	b=sXjc64p6PKsgLKvvgJK0sbKEECSA4Und8ZOF0i8RXyrkg0oACUTB7DO1H2orovPbaPkI
	 0vdWUW+9lh/N3ULVu1l/w5Aqzvz86xbvBexq4PQ6Ie5JcQElnxL0OMICJt/EW5ckGv1Zd
	 +wOC2vPYx9P0qBlqJHwuYx088cDGvWFhXwgWgloTR95DYG7A0VEWlQqi+TebnvCepxQ2X
	 JRr4aMgB0d6z1iy2kh8yc5BoECnieYusqsGiYqXTL1gpPqvHPaimFYQHAVzVTwiGGW496
	 xowWt0xCNL06fftZ2hSNzaqkwv7JhBE7UFW4YNbb4fp1eEUF1ADwQn/aMHnker1kRiA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792513730;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8GCq0bTVh4yie0TWDWgdrW8f3IBBSZUxdZvQWHXs5MM=;
	b=iq9beMtL6pn6ufMKv6wAV1ezyD7knPiHV/WWncQYyzvITdnlfk1XW+cCjqBJcOYyR+MR
	 K65p89/fqLvHnPJtqpBQWkWgcf59bU/Iu8gkNuKtBI3QYzaTjSknhILeHBPEn6oSFHzcl
	 YoQKfm/zLMUsCcraX7yS80GqGHVAxb/DWxd7eMeXLQBzPCrfty/x4snDHjKRJHobS5uv+
	 SUAobafW0DheREDPME7Fovn4kSH4nJ8wPxpyi0qMWQJYYEM9BQ3tT/IOkJc/wNeEj/UZO
	 uhP3QyqXIl+5qbJW/AnNvIehs0TMqPo8DdDJnP8fYcuwYYVJZq9hBloQgJJoBIpCUmA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D29261F000C4;
	Tue, 20 Oct 2026 16:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792513730;
	bh=8GCq0bTVh4yie0TWDWgdrW8f3IBBSZUxdZvQWHXs5MM=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=JxlVKwB+VNZLvC4zVQ7QDUOpHiyXilbY7hmCQsxR6TYbTipuXzop4F9PrSM/JSNIM
	 fRw0n4NAK93I9yQPVCq3pvj9l1eDvU4BEnbiPyd7GyUAs9cyEOMYS2VotzpJzhSV8J
	 2IhSD/LjLoB5RPa9teFRp/6a+8sJtomq2t0s2/yh61zUTUbwsjindis0zjc3nRJvOs
	 b6Sxs3TnQ79o0LzjzB/I3GcBxrjONtO7pxZ21hmlhxYaMlGV2NFzdnvdLEgbYDHNSL
	 C1cAXzNUFZtmdTGzrLoThxqRgmcBiCwwo1cmp7CoTap751yDYIkEVuaQZtvFqwcbfr
	 IWOVDsAHoK0AQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3819043181;
	Tue, 20 Oct 2026 16:28:49 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Tue, 20 Oct 2026 18:28:47 +0200
Subject: [PATCH] iio: inv_sensors: do not compute period estimation when
 updating odr
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
Message-Id: <20261020-iio-common-inv-sensors-do-not-compute-period-when-updating-odr-v1-1-8fedaea8116d@tdk.com>
X-B4-Tracking: v=1; b=H4sIAL6W12oC/yWO0QqDMAxFf0XyvICWzeF+ZezBtZlmYFKaqgPx3
 1e3x8OBe+4GRonJ4FZtkGhhY5UCzakCP/YyEHIoDK52bVO7GpkVvU6TCrIsaCSmyTAoiubDxDk
 TxrKqAdeRBOcY+swyoIaE3cV319a75tz1UCIx0Ys/vwP3x59tfr7J56MK+/4FUaV3TaIAAAA=
X-Change-ID: 20261020-iio-common-inv-sensors-do-not-compute-period-when-updating-odr-95c976c2149a
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792513728; l=1865;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=8Snz6Ctm/7LdgRA5eD0zB/7H++w98rHrAjXN1xYIlKU=;
 b=Le61TwPfhQPBKNrGmU3ULSPxaz0wNdQNY5G29RbKIMIZxkZHOnyTIK7G9gK4WwaXSrorPHazY
 ny5OuEEJiEsAPBIK8eOkMvTG5k5o8SQzFX4KWVDgSxznQ4oMpyGLItv
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com
Content-Transfer-Encoding: 7bit

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

When odr is updated, the delta between the interrupts will change and it
will lead to a bad period estimation.

Avoid this by preventing the period estimation in this case.

Fixes: 82bd09ce4fd3 ("iio: inv_sensors: improve period measurement by using a longer delay")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
index 8c9e81a77e68..7ccd5d5a6986 100644
--- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
@@ -142,6 +142,12 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
 	/* update delta timestamps and estimated period */
 	it = &ts->delta;
 	ts->delta_counter += sample_nb;
+	/* reset in case of odr change */
+	if (ts->new_mult) {
+		it->lo = 0;
+		it->up = 0;
+		ts->delta_counter = 0;
+	}
 	delta = timestamp - it->up;
 	delta_threshold = INV_SENSORS_TIMESTAMP_MIN(INV_SENSORS_MIN_IT_DELTA, ts->chip.jitter);
 	if (delta >= delta_threshold) {
@@ -161,7 +167,7 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
 	it->lo = it->up;
 	it->up = timestamp;
 	delta = it->up - it->lo;
-	if (it->lo != 0) {
+	if (it->lo != 0 && !ts->new_mult) {
 		/* compute period and check validity */
 		period = div_s64(delta, sample_nb);
 		valid = inv_validate_period(ts, period);

---
base-commit: 43ffda3c7f8456bbe641ae8249a077a361b97880
change-id: 20261020-iio-common-inv-sensors-do-not-compute-period-when-updating-odr-95c976c2149a

Best regards,
--  
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>


