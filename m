Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793348659;
	b=NMGOl6RHbQLHmHGokntPLEVE4O49uLJrkp/QSOLd5NVZ7htSw9TG4jGH7rpXbhi5bXmE
	 nqRh4/3DGt1vRlXHZeF3sQQ7zpb0LRGkTqea0jzMMUWcfj09vYZiNmR6ND3CGX6Jm5pld
	 +WUib5NPO9BYqCIlgSR1LAz9aAM+oWGIT7mgJ+6w2TFASSvgOUgtsz6NSDIr3IF0U/gCm
	 JGPOn96pPdpKQSb+MqpWTadD0JLRJxuq6WxTac+ygI1YBka2zkEcdKpyCy/Fv4ibTDUxd
	 2h3UBMJM/hTciO2QHf/LbxdIki8XnL5jWAA9rkQtbUXTfcdgH4v9p2ln+bDe5t5xdCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348659;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 Organization:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:
	 X-Spam-Score;
	bh=YwZBd/0roCjOlvI/4C6fNN+0JIHd6QEBCRZosXw8BJI=;
	b=VemD/t2MEdqUBLSufKTtyn73xxA47PcCIYMhjHGG2zJLSzWaa+jk7uFNpuM+oUXoS0Y5
	 X9zonz0BELWG9uAhhMPiQNxlW+YPBRjEuQ8mvAXFYizOCbQ8Y7kwizQvFyJuiqzre3YM4
	 X/LmuFj8qTT459+4E6AOpp/mGd/2WpW3aooW2M2EgwqQu0ZjdkecsGs0pt/0t1kmxdiwj
	 f2s7Ie1hET3LRi+B0SNzja0yBYNAwZO3HauPvqJ15cygY4LBwc1o5yBzj49CDkWfH6faF
	 mCUzNONpghd3r34vmurV3kX0OlGLuZz/LvPBceny8QmUOK3+ixvoptVunn68XpGtz0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=hd1YyzHA;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=roOpJBzc;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=hd1YyzHA;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=roOpJBzc;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AD7606A31E
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 08:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67AD7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=hd1YyzHA;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=roOpJBzc;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=hd1YyzHA;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=roOpJBzc
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ABD7B1F444;
	Fri, 30 Oct 2026 08:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793348656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YwZBd/0roCjOlvI/4C6fNN+0JIHd6QEBCRZosXw8BJI=;
	b=hd1YyzHAQwKsy73RMRkhUwQGyomiXs4duPpbBMLzccDuW8Pe8wfAEM/hOKiIHoneyNzXXj
	/EfjEWY8Qim41mwkhmtp0CYkDxJQOcKsVoRq2NoHdESDU+B543JyhW43DpEyO9ah6y18ph
	VxiYQ3K3zkWDdIPN//AG/e0nG6cwL9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793348656;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YwZBd/0roCjOlvI/4C6fNN+0JIHd6QEBCRZosXw8BJI=;
	b=roOpJBzcMmaqMLM1RGSiflM4z1kvYtq8vkVTcnha20SK8Dn2EAYDK2KS/04zpa5O+rMhik
	3yGX7BQDLJPmOtBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793348656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YwZBd/0roCjOlvI/4C6fNN+0JIHd6QEBCRZosXw8BJI=;
	b=hd1YyzHAQwKsy73RMRkhUwQGyomiXs4duPpbBMLzccDuW8Pe8wfAEM/hOKiIHoneyNzXXj
	/EfjEWY8Qim41mwkhmtp0CYkDxJQOcKsVoRq2NoHdESDU+B543JyhW43DpEyO9ah6y18ph
	VxiYQ3K3zkWDdIPN//AG/e0nG6cwL9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793348656;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YwZBd/0roCjOlvI/4C6fNN+0JIHd6QEBCRZosXw8BJI=;
	b=roOpJBzcMmaqMLM1RGSiflM4z1kvYtq8vkVTcnha20SK8Dn2EAYDK2KS/04zpa5O+rMhik
	3yGX7BQDLJPmOtBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6699813419;
	Fri, 30 Oct 2026 08:24:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HZ3pDjBU5GoBGgAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Fri, 30 Oct 2026 08:24:16 +0000
Date: Fri, 30 Oct 2026 09:24:10 +0100
From: Jean Delvare <jdelvare@suse.de>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH linux-6.18.y] hwmon: (lm90) Consistently use our own mutex
Message-ID: <20261030092410.0e585c82@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.50; x86_64-suse-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	HAS_ORG_HEADER(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.80

The backport of commits b09a45601094 ("hwmon: (lm90) Stop work before
releasing hwmon device") and 873e919e3101 ("hwmon: (lm90) Add lock
protection to lm90_alert") to stable branch 6.18 makes use of the
hwmon_lock()/hwmon_unlock() API. While this API is available in
kernel v6.18, the lm90 driver was not ported to it until v6.19.
Mixing the use of different locking models within the same driver is
unsafe and should be avoided.

Update the backports to consistently use the driver's own mutex.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Fixes: bed1fc32e0eb ("hwmon: (lm90) Add lock protection to lm90_alert")
Fixes: c98107817b0f ("hwmon: (lm90) Stop work before releasing hwmon device")
---
This is needed for longterm kernel 6.18 only. The backports to older
branches are already correct.

 drivers/hwmon/lm90.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-6.18.orig/drivers/hwmon/lm90.c
+++ linux-6.18/drivers/hwmon/lm90.c
@@ -2614,9 +2614,9 @@ static void lm90_stop_work(void *_data)
 {
 	struct lm90_data *data = _data;
 
-	hwmon_lock(data->hwmon_dev);
+	mutex_lock(&data->update_lock);
 	data->shutdown = true;
-	hwmon_unlock(data->hwmon_dev);
+	mutex_unlock(&data->update_lock);
 	cancel_delayed_work_sync(&data->alert_work);
 	cancel_work_sync(&data->report_work);
 }
@@ -2963,7 +2963,7 @@ static void lm90_alert(struct i2c_client
 		 */
 		struct lm90_data *data = i2c_get_clientdata(client);
 
-		hwmon_lock(data->hwmon_dev);
+		mutex_lock(&data->update_lock);
 		if (!data->shutdown && (data->flags & LM90_HAVE_BROKEN_ALERT) &&
 		    (data->current_alarms & data->alert_alarms)) {
 			if (!(data->config & 0x80)) {
@@ -2973,7 +2973,7 @@ static void lm90_alert(struct i2c_client
 			schedule_delayed_work(&data->alert_work,
 				max_t(int, HZ, msecs_to_jiffies(data->update_interval)));
 		}
-		hwmon_unlock(data->hwmon_dev);
+		mutex_unlock(&data->update_lock);
 	} else {
 		dev_dbg(&client->dev, "Everything OK\n");
 	}


-- 
Jean Delvare
SUSE L3 Support
