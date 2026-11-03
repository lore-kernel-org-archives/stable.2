Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793668498;
	b=c9rHcaQhTQhFa5U0/tfC8ENmosuXBeq3B7bZLpTQRTqso6QG2ts5sHL48dT51spgpRVs
	 9IfmwR6ebntUUde4Acq4owNtXFWhrA0Ss9ZXH/l1gO48i1gs3+PfvUoFFvkJToFJhd6du
	 7+8BaD1weZP8fW/DzTF2u3kS1nj6pkReWWDSyh14GPHkBugFVl5rbiQHtUEPEByz2jZbt
	 ltKD1h1R+gG9WNn+VOA3g5e4Ue9nBkB7lOGk56+/BrpTqXHmGdcGxfGgAJmwznoso48VL
	 lEVSjH2tP1FNiTuYzuitMyQnPpNsD69PaPP0hZtOLvbYziNDvmt8SUCqdHlcrK75aOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793668498;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ea+D4XvQXS0wApj/sWZ9FEvJHF+Ta5tWsX5SDWfsCYA=;
	b=4uuopLCm5W3PXcylxPUVfntGUXml8hbSBLTFadPkhtf+vOf/WTz7GCsHkbDKTHbrYHQX
	 FKkAxJ1WIaCOZEhjZ+KKwcOs+UCoB1olLpXNq6OsT4fM/qsTn61Nf8VzKuY/VFy/MV9pt
	 t4G2y7QSCtvK5VFxdkGCaAOf+628dnLrGvSiWByZ4YQxvfwSZ5ip3E/1e2fMASxjKTtVU
	 t8TmPexR0zkc0WcoVK4/auWz+k8GJYFbP8dlYX+zQ16Jyf3lkeNAUnpL4/6PkUEtF7l7f
	 EeCyyup8Cy7/mjix7/otN2FvpThxK3dZ2Af5ZX5MVF4rdWhPrgLMCnXcfyMrck/lXOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE0A606D805
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 01:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEE0A606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36a17a332ecso5627980eec.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 17:14:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793668497; x=1794273297;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ea+D4XvQXS0wApj/sWZ9FEvJHF+Ta5tWsX5SDWfsCYA=;
        b=O0abPNrJIZDZME9jKJ9XW8bnrAFqgzl+ki9xwAob38YFKQsm1ECejFLP772Gg9euFc
         Xhd6adzUzWbC4J06tog/Wk41bFIzKZXETrPn+EkkfuAuWXfsUd9rtyxQaAiOcmIJXvCg
         oCp5eK7TZB/WBvqTD8MxNaDOuhl1e2hHEo76gX8nzwCRerzhogg7HP4dZWEe8mj6mvcK
         A76C+7jsuXlEwboDyUgb0WWC9KBeUceQUm3E2bIRLj6ZywXywL1BKeaEnOzlqCw4HZGa
         5tVA8h7aYfEb1RAhYd9SZlyKvVdMeFrpSg+lH4yuTQU8QLkiLE+7xfYOQXXuTQEyvhxU
         0Bug==
X-Forwarded-Encrypted: i=1; AKwUvBzci988sExMfLZLdekEbJxiITqBtjmmkQxCmVjExGujHWswRMFZ3qCOfwaLjseWctPXMwyFMzQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/lg+ARouSvfJaoJjWpHs+jGrX7h2zNFfa+yMwOv3qhv8rMc0ut
	9q6Ckxw2RrjsUfeL91MlEAFeatgIBhgwNGGLEb0iZJddMl1fF9AgiZNE
X-Gm-Gg: AYBFou0MLR62Di6hV8N3k18DI7cS9Ovy9y3IEUvjip5c7mmMpwUnyvN40iVEbzmwukr
	39eyz10QSxR39u5O/64xi14PoHxk42DO1w+BRNexUVKpXOfoGBRutm6xDCMOkk6MTwqvRI7zYpI
	cg7hBVgy80nUkgrNYnxnzAheJ0gfmPVtFGMXv4UTkI/zJd2qn4BS4tOEbq6RgF/5ILUUtvslTSh
	mArSe6veZ3NcVkrJWF4E4wiFTJlfQL/fgonjK/oX42q18p30gECtkQKTVmvcqT0irxKD28BpU+M
	rEAdFZM7phY2F0q2mhvVwgq4ST5UPqzHywDTLKHeEV6hWrRCecBWeNO8H4FC75qxbC/a1Fz2tnn
	wnj0mdqGjtDzuyYrRSR2eESZ3kV+bPkRBdKAFZelVLwc+n77DcOk5Korv6gRrpwP4zNhzmHj0dC
	I83bx4sZFJQMuJBLoBDZBC1VghPhMAnOJqwCz1FokjlImgLgeB45op6wuBCSRpqNF3qIsIwpiLx
	XL40/FQ+vK2hfgXrjWUsnSKOhNPWeSBdTzLvhlb4+2gQtas8i8fvgUtmhaREdnkF11b6RheAIM2
	eTZ1d9TDOli6GUW02wICp2hPVeV7tOITVDioKJS6dYYqxw5A+w/+nY1ZMYcvetQXpY6uMpATBeC
	2DQxmBNJWDLUr51bq8a333MA3FPHETBtm0FwD
X-Received: by 2002:a05:7300:b0a0:b0:34c:d1f2:b552 with SMTP id 5a478bee46e88-36a422255afmr18552566eec.4.1793668496818;
        Mon, 02 Nov 2026 17:14:56 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2602:294:1:b9:a2b::1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a426681aesm51988583eec.1.2026.11.02.17.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 17:14:56 -0800 (PST)
From: Hongyu Xie <xiehongyu1@kylinos.cn>
To: samuel.thibault@ens-lyon.org, speakup@linux-speakup.org,
 linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, chris@the-brannons.com, kirk@reisers.ca,
 w.d.hubbs@gmail.com, stable@vger.kernel.org
Subject: [PATCH v3 3/4] speakup: Guard late sysfs operations on speakup_kobj
Date: Tue, 03 Nov 2026 09:14:53 +0800
Message-ID: <179366849349.70545.11202194243719221212@kylinos.cn>
In-Reply-To: <179366847311.70545.1738521378158835923@kylinos.cn>
References: <179366847311.70545.1738521378158835923@kylinos.cn>
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

