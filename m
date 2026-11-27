Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795770054;
	b=KmWNP3pOMFu9Iz9SlevOuYZ3S5xNv7pBwIuZkMoAdTXrgsjUqvCwN9Af7TcI0ROL8Msm
	 woIwULovqQHclSFwEp6TjrhY3ySglQzrziyv9yhY54CI6FRL8TCe0Jx+l33FaDGzSeXPd
	 mA7zIVbkA7npEVldllqUZpsb+Y5AUXPWhK4/MAAd+MIdqirwN0SHVVA033/ByS8SYOo+q
	 9OIs/7VoH+RQa8OSBoXZmae+3Z9kYes+yCELKzTUiyFO+pKVf/rsjSWi46we8TuXzayDa
	 Nq34BLl92m3L8npu3sapdLxXtcXJT/OJ7VjWG6JMVNxEccg64k1UCgIuucR52l7c6Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770054;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ea+D4XvQXS0wApj/sWZ9FEvJHF+Ta5tWsX5SDWfsCYA=;
	b=1GRoxxmnPZV9GlaI/CfQS37m/J0Iwjq7yfUvF5KTliQsz/z9LzFKzz88mNfougvhHzpu
	 DOPImjaehEaXEodD/eB90LJOHSY0U9oT5HouNcfpWmw5neULQm1I2CItrDiBE1ohZii+P
	 sAEdnfXKZuZXxgSOI21xH89C4p/i6ckvd29/z9zTi11AHFMfnQk3vD1KDuy49KlQWuqzf
	 zE/Y+6D+4tkaR0lqtakH6VUCob63n+sw0HajW8wXqNAx6dQjLPXx2yz3j6FeuP7vLxlpv
	 GF7gowrd/MldqY7epeG9Crppws3JZQCZ6Y6dsxujr6mC9UdcLOsztE++0DFMqN/063Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3C3606A690
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA3C3606A690
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2f037bc348dso62374555ad.0
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 01:00:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795770053; x=1796374853;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ea+D4XvQXS0wApj/sWZ9FEvJHF+Ta5tWsX5SDWfsCYA=;
        b=zO5n9Va+ne+eXDm7Zb3W37QjZyvl6x8YXhLv2k/43LO5y/k+lsZogZIPKZWHjWqy5K
         OmpummdS/w29KBUJp0Jdwo2yw79BDE+QNa/ewo9JhGM7lwTZuXghVFALHs2/yXY1ikBL
         sitsUCHUOHsrPtMKtjsTYecyA9asxBcJKPS0t8WnaKLapl22dxbdUr9yXTKXOCr13cax
         /dugymto3wn9/v929TmYFScPefkztOvVtHIllDtaeooM3PvLPAiMzx42YLXANySySZ2I
         fr3k0LGHldfnutACdwcGknLIUjjnA2ocp7dMHQU++Sc8HBvwVgrns76hYzKbRawEb90k
         Zpnw==
X-Forwarded-Encrypted: i=1; AL+hErFG4NnKSioEQ4junp80Z2gucPELxIpqd06MxoyZym1PefzQCHAwe9Jf6gzwnRab5r1VX8N1MvE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8XQGvbVz5F2GkxDOphHf7ie8leOiyYOLL9FKUmryxFXIgI/r+J
	AAyXZWSzHw6tu1KY7vMzzL8JaChmmaFkVpcdQwC7YwzxEtqWNQhpnu6F
X-Gm-Gg: AZFdTZcCIKwk+Vsh55aQF7Ruej6lb81piloUNfqsdrf6pV0PcziGNf+LrwwXpMF/rk7
	K35dQiy/rOAHwmQ8kRYD3sTg7TG8zqIFuA2Qq5RRE2nOWQDumqumuGl+jqiqWJuca4tVcv7RMgQ
	z+HfhhAb6DrstifUlgc0f/wZK+TkUFLQ4dqEMPSIGmjDyy7FNbkPUin3odzI2SNEljQn6PoGcbr
	iWO0ztyzZV0dQoaipIZlaSOGxvRQCPUA36dUhM8od6AjhXP+mNSc38E18uq6MskHMcTlKu4whRm
	rZsOM5OREalC/Ueyg9Uq2diZ7aNz6pm2qAasVbuwsPo4nLtKzQd8RVtsECfH16MZuqrKqUMvCoj
	7OSpp0X3QSd5RyRIwnvnsHFB7ZjKGXhaeaE03Uc7FuuA0MBg73fgyNA5C9GKfKkZG0cn6JjBpRM
	opVZmAkZK2A0lhPIeQOA3eog2XwfbXlIA6I7T3Brfd6xCSABlfiju/YROfarx/xhNyPVqBUOx4z
	z7RdZ+r+EzkXGVeQAxrbaulp5wjfrCeBft3r9FQ0kvXXJZZtZweai4odFZGT/N3kFIQm98qHqaW
	8YnAl5/nSMvkdnyUZStxEGeIs5b4H+11T1Y5zcu5aEQcUMT2JYy7p0j0JhJH4k3QGPpc8bG7Hoy
	rEPdxWA0ZIs6TFdeHuN3GbuczHhVh+SUPc9fS/4GS34IguMU=
X-Received: by 2002:a17:902:e88e:b0:2f0:4f8d:377a with SMTP id d9443c01a7336-2f04f8d38d3mr223125215ad.34.1795770053050;
        Fri, 27 Nov 2026 01:00:53 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([216.236.36.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f120769sm117050725ad.57.2026.11.27.01.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 01:00:52 -0800 (PST)
From: Hongyu Xie <xiehongyu1@kylinos.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
 chris@the-brannons.com, kirk@reisers.ca, w.d.hubbs@gmail.com,
 stable@vger.kernel.org
Subject:
 [PATCH RESEND v3 3/4] speakup: Guard late sysfs operations on speakup_kobj
Date: Fri, 27 Nov 2026 17:00:49 +0800
Message-ID: <179577004929.23588.12751621212376213236@kylinos.cn>
In-Reply-To: <179577002884.23588.802785530849276690@kylinos.cn>
References: <179577002884.23588.802785530849276690@kylinos.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

speakup_kobj_init()'s error path and speakup_kobj_exit() drop the
kobject but do not clear the global pointer.  When built-in speakup
fails late in speakup_init() (e.g. a kthread_create() failure, whose
error path runs speakup_kobj_exit()), the dangling speakup_kobj
stays behind, and a later insmod of a synth driver feeds it to
sysfs_create_group() through synth_add() -> do_synth_init() - a
use-after-free.  Clear the pointer right after kobject_put(), so
the late sysfs_create_group() fails cleanly on its own NULL check.

The removal side needs the same guard: when the kobject setup
failed, a first insmod of a synth driver fails in do_synth_init()
with synth left set (that error path does not roll it back), and a
second insmod goes through synth_release(), whose
sysfs_remove_group() would now meet speakup_kobj =3D=3D NULL and crash
on the NULL kobject - a crash the NULL clear above would itself
introduce.  Skip the group removal when the kobject is gone.

Fixes: 2067fd92d75b6 ("staging/speakup: Move out of staging")
Cc: stable@vger.kernel.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
---
 drivers/accessibility/speakup/kobjects.c | 2 ++
 drivers/accessibility/speakup/synth.c    | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/accessibility/speakup/kobjects.c b/drivers/accessibility=
/speakup/kobjects.c
index a73b478e06de..e1860f8d9d42 100644
--- a/drivers/accessibility/speakup/kobjects.c
+++ b/drivers/accessibility/speakup/kobjects.c
@@ -1041,6 +1041,7 @@ int speakup_kobj_init(void)
 	sysfs_remove_group(speakup_kobj, &main_attr_group);
 err_speakup:
 	kobject_put(speakup_kobj);
+	speakup_kobj =3D NULL;
 err_acc:
 	kobject_put(accessibility_kobj);
 out:
@@ -1052,5 +1053,6 @@ void speakup_kobj_exit(void)
 	sysfs_remove_group(speakup_kobj, &i18n_attr_group);
 	sysfs_remove_group(speakup_kobj, &main_attr_group);
 	kobject_put(speakup_kobj);
+	speakup_kobj =3D NULL;
 	kobject_put(accessibility_kobj);
 }
diff --git a/drivers/accessibility/speakup/synth.c b/drivers/accessibility/sp=
eakup/synth.c
index 40870949b3c6..1af80eb116af 100644
--- a/drivers/accessibility/speakup/synth.c
+++ b/drivers/accessibility/speakup/synth.c
@@ -580,7 +580,7 @@ void synth_release(void)
 		wake_up_process(task);
 	rcu_read_unlock();
 	wait_event(synth_catch_up_waitq, !atomic_read(&synth_catch_up_count));
-	if (synth->attributes.name)
+	if (synth->attributes.name && speakup_kobj)
 		sysfs_remove_group(speakup_kobj, &synth->attributes);
 	for (var =3D synth->vars; var->var_id !=3D MAXVARS; var++)
 		speakup_unregister_var(var->var_id);
--=20
2.32.0

