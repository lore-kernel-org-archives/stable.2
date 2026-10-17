Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2B538654F
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 01:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201218; cv=none; b=tvn3WqRiqAezMdn26h3rZkOGx4BnNS71quftfOwVCPYFfkTnfUerkBCMhP8NYTAHE8gttD8CxCjORZ2jV8oul4SMjNP+jrADO09GDwPbzvBh8+gXNU0GHpIw7ALj8iZHsr6N7jilgBjvP4kiwz9a/GvvZKYc1i9KHUhW6gkYwHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201218; c=relaxed/simple;
	bh=ap9ePz+9PV6ufOeUJx8Qbab0l1IL7Xz3NBboXApR0a4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkQpTGz8OGPSC+uzxv66eLoO3yWSmRlOazqYQ8vGyCOWQupiuPmb9pkA4Q7ZtxqF2Tk3K31rnJnIHG8pncIdh5umr/46pks5SKZauvF7hOV+gDpMvuTpzi1Kcxl42r54DgY+C/pUEEalHbEDGLqM7c6v98HgbeC/JfvCgP3CIfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVgy+QxN; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVgy+QxN"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-144f79153f5so1293656c88.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 18:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792201211; x=1792806011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5bYkTuU5A/bCkZlXHIgBMm3vkDI/xApJANJAk++gOls=;
        b=kVgy+QxNeQmUtop95axvQfj9JtvdNkQNSr56P38igpKUNLY9MU7LIxxzD3T3zrY8Ro
         LOB7ziT/q75pokly/OVycnJseXOkdde2Dc0ZbxJW0qekoP4+TwEF97SuR/oj2LnogUDd
         nK5Wcy47Zj86PVNviIWpytGU074Uqz4+S7ll6Rq2w2idx+SKWT6iZDVpl26Zybbh9Sb5
         r+XEGjWQeGZjs5l+sNhP5FUkq8JOLj+kn5yBOfM91OYlH9ZG9gVvKs7aSmjb5tWaby9w
         FGvjFLCO4F4GEYIjnDZfRVqVp6QYjZEBJDxWwWFqh1i/yDB68ME1ySXEkrUbuLhjh0Hh
         aAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792201211; x=1792806011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5bYkTuU5A/bCkZlXHIgBMm3vkDI/xApJANJAk++gOls=;
        b=IoI0aPnVquPqqOzaYkW+QFkpV0e6uoMXJ9HrbKyA81rFmkKAmW/HX5Lno9IkHUs501
         kM8cKA7RLzMFWtCUGRqUne2g2HXls6NLr4BaYq+ulr+3Um9dYYPxLQQwVuPkkkEbSafT
         FS46VbNGVBRg6PmRLcvAk+Jbac1GfDNlJXruEunepOVXN+1UhwEIMjNBFaO3/Sg3IMkO
         qRZ2GSODfcF+hhae7Psw6BXEHRrU23J8oa4RQna+2X5rnKqTGdH0kSRcHT88bDH8WUqD
         8OJlufzDwOIzJKPlvBfSEVpNogahvBoExWogq5G3PjDHIdEb3Bt5FtBWV1CIXs/MzWOQ
         9Jaw==
X-Forwarded-Encrypted: i=1; AKwUvBy7Y++BD6BQjFiFTDK8wQW9wvMU/LdP8LeM8BUGErafI1Aq8i/+6EQ4zVmFH4UqcnPfOrPA3hw=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8Stf3kfVf2RBfO/RUlzsX+PXLVI4uW2WH0c/HIPdDS4c+sLUn
	zODPhVt/EDm1bCw7qYf4gMm8KG8WhPNAagVpkWo150NMRo4Tvm2gRzoi
X-Gm-Gg: AYBFou14B/id/qCSQzXLMBlgxoSho6Q9PXVlEMxZN+dTBY2vlCGgA5ti9z9AMdufVeF
	Jvxgl5UISciKND7nUl7W60rU5n9VBdtaANqRVnyRfiRg+90cL38FSKOvMOJ+vlprPQjFsJEAzXG
	z9JPqFWK5XIMhOk5clSgSTh6TYAPrtR183lmX1yJckXXKJIRn5wunnj3ErWMi4tT4clSjazq+Hz
	pvoHuyhctMmgad8Bf3AWPGwCOlPqW8tedusfJzI3MbEGuqW2WuupD92qPz7t7h9j/HRkFemLzc3
	yFigMVcGbaqVf3gi0aeFP9lv28sWIT59RMPGkF5wkH4aIWm3sTzfGcBpQULEBnv3YQhjivTN/Aj
	l9PHRvhafzP530Pw3GDIcbNuU0juz11QqG/HbRymfj5i1j1KlV/VQQdFihd0tXVUwPjuihucd4E
	04jVaR8fJwpuh3jQsVbXbEE1YZg+tJAfcBfu1wRvw2JDGeoBtRKOJFRqePE0BClqTKhnjBR+cfs
	ojU40xWrSqiATZ9UPM4+ILNNn/iQ8dEmAdaz/CILoNI683caHuYEjE1CchZZ8r0lLAPcpmOJqUJ
X-Received: by 2002:a05:7022:b043:20b0:14c:c588:ac21 with SMTP id a92af1059eb24-1851069db0fmr1875193c88.9.1792201211295;
        Fri, 16 Oct 2026 18:40:11 -0700 (PDT)
Received: from lappy.taila8a9bd.ts.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831acba710sm12128429c88.13.2026.10.16.18.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:40:10 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	stable@vger.kernel.org
Subject: [PATCH v2 04/11] HID: hid-lenovo-go-s: Use pm_ptr for reset_resume callback
Date: Fri, 16 Oct 2026 18:39:49 -0700
Message-ID: <20261017013956.2440130-5-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
References: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds missing pm_ptr to the .reset_resume callback for hid-lenovo-go-s

Fixes: 3524900cc571bd922a ("HID: hid-lenovo-go-s: restore OS_TYPE after resume from s2idle")
Cc: stable@vger.kernel.org
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index b27e82ec9b76..a16733edad5d 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -1560,7 +1560,7 @@ static struct hid_driver hid_lenovo_go_s = {
 	.probe = hid_gos_probe,
 	.remove = hid_gos_remove,
 	.raw_event = hid_gos_raw_event,
-	.reset_resume = hid_gos_reset_resume,
+	.reset_resume = pm_ptr(hid_gos_reset_resume),
 };
 module_hid_driver(hid_lenovo_go_s);
 
-- 
2.55.0

