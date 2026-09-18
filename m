Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06C94E36E6
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789733451; cv=pass; b=Bkm73YezV847CFxT8PFjGfZsvNtHUqdReKv8z4R48cZrKMC0neRyW+w3vcyx0roMjtp2bxUXI6cj8Cz+1zmBrv5i/id0XprT3Zb+KYEeneJQFeAxFFEFWqJGyY816tbtombR3x4PP9CA6xX24A3ZkfZfdFvXEDvnvJtQFpANi+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789733451; c=relaxed/simple;
	bh=K7ZluiYUYcSbvc0z9QMWO/augRKhUTEPpypnqljjxCU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=W5b8ipkNdBsCfRvdXYtE3/F3JNzGkNkZy7+uiNtG0tTo5kOka1bTjA2FxnVaFI1PjiA+Dp8gNn2H46Xwk+DW7B/h44JXCyKPwp/n32gbOI/LJ6C6jbnMkMja/fDfPSrIYiiv6T9XZLTBh2UVeZECX7IoavUhjklAn1COnYP2V/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXIQD9ub; arc=pass smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXIQD9ub"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-7f4f0c89e34so368304a34.1
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 05:10:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789733449; cv=none;
        d=google.com; s=arc-20260327;
        b=agFmb71Xmd+cwfIg7WNPt8moaWENUj8WwqkKmOLuL+dR1Mrbj6yBkZRWLVP7h1MKPx
         HV8n0IrWR8iS1+A+Li4K7lJen24ciI6ifNykUFcO+P+HtFTyvu47PdKNwbfdwnL6nfwV
         5OtWsA1mPbN+9OLbLkobYIfUL9bKwve/utBfLeLnHTtWbnOTLKHWrZ4AZ1CcEnJ39IGi
         zLePdemOQK+9g67ylZeQObmtf8Y75Wzl7xkpKH9XlyWJC+23r4OFTmw4ozoJJb2ckvwb
         YL/6CWrPOp7KEXDQFoUzEx9lz0vsssO2v8I6a25LzlUdRigorJBVCTtb67HCG8eMSpYt
         0NMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=R+/N2TasieDArJgvhLgm736EZPCPdtsjAgNgRN49nPs=;
        fh=u3CldR1aPwUPtSyrZVcibdfeyciSJ8WKEC+0eNdim9I=;
        b=QVXqndHJWRONhTOTupUGJ/6qHRrW4NlhIz9WZNa5u15PND67ONKmUKUpBnmSDHho7t
         WhcIma34qKMukI6QSJO4tJHBnIudob9hUVL+ElnBjeESDpMNxGQRX6yv23RWK3a5fyhh
         48IzQbRRrbR+8EqWrSVdk35e2dkayW7Gi9GITxW7nrLDLbJDsvfAS+H98b+fUxDkE5/I
         /s5cWOeLT8q5Jk0Mw5/x1ntjzgjCSA4SOKvGmjr64vNG+XBsk+lK086YfHb5tfvcnIRB
         BmHgnae5+pQt/2gM61FEctRMybR0DumKlSgWNAoYakgBEGb/IHYSch83M9vz6r3Ad5yo
         yIkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789733449; x=1790338249; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R+/N2TasieDArJgvhLgm736EZPCPdtsjAgNgRN49nPs=;
        b=QXIQD9ubXMb6vQ0ZfhO+cCRcvAJ7lEQD6V06XY961GoAxWFPtgOObcZRYn9DQ+Ov+D
         f+JBOyi9l3hbAGXdI1amesB4qDG/yg/6edRwtjcJsLhsCmx4vNQ0rlNLao1Z9AvU3SBv
         pa9yJjRbuamyLHSsCEVfu80vWxPj3H4mfEnIDCvrpzZX9aA8MoKne2o/D9+S2C/hZ5DJ
         pSw61dgl03pmbUMR3KXgJwoy+baEVInKQ4ujlDbaPAvSWKKqvIwkzYGn7v2TV2Dg0wuZ
         pclBo4zqzDrtt1cauQPywDwEQga6MHqmTZK3A5Vx6pqQ1w/goaECXYBZlBIKEiWOz5Pb
         HlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789733449; x=1790338249;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R+/N2TasieDArJgvhLgm736EZPCPdtsjAgNgRN49nPs=;
        b=ouOpLiC4ec1O2WvUgnYdVfdvJk8qZX//pkKub0SZ0RTSYMnsSgTz9rtPXjCWKMiA7y
         OADP8TrkfPT+6aqORY/Xx0m7NT2QP7vXa2HsGCbhWOJYvuIDL/xE5EgyCClEv7xYGcKX
         y6iLYR8IR7pakbD1UjTYXQa6M+jVY+yqZNk3DBeXWHcDgqSMptLiHeFcl0HWSno4rJbS
         QC8aqHg0dAS8B5PQOlLrVsHbUf/z0m7XLHo1qaTZufB4p9ddM1j6tVtmsqp/Rq0ajcM/
         p2Ka/vB8hm9yUzHrc/s9388+f9YR6Gc0pQWeaSSKa3LEKDVAjnNlKSre/RFW4rsGY9Cf
         FZPQ==
X-Gm-Message-State: AFuF++ks2M8dplKyXmP1k1hD8owL6/7FvDppwUaUHbIdlPMMON8eRvY2
	EXHkL+UxBsRnGgxraQuBvqmQeksVEeCC+Y3c4g4mMwEdlsZlI66Qz9jZFgWqrwXWkC06oXZa+6V
	fMogvsdjhEFf28O4+A3+u2GTllbd4ekxpt+W35CI=
X-Gm-Gg: AYBFou0nbsZkH58WvuvTyO55gEX3u7RNTuQpeq+7Kq2oqN69xc73OksUwtBgwP7KbA4
	0MfmcId3eC4H/qbSJ9kgzjn++KSg5d9Dy6H6yNJF7BL074hWKwjrZ/hUxsnn+PkAQVp5zgj6ubK
	JIVZ2Ew8ISxc1KGF9JTpNJWPsIcNJaFVyV0iIWHMtQzLq4XXfCRBMRT9OgTo2Hpk12+kj6SUlAt
	6esnUx/xJ+Vos707fCmgJ7rGmXRtErHN15lFdWqUjn9FNBPXE8/dVMM+hs+YuW94EqjptbCmhVt
	bvlPUS/l34mIlWNY7wf4q/m3hc4STho3l42e5DLa00Kl0ogy9Os2jEpiUiHFTYm7IJVYUcqe4Cz
	q8VSGpr0h0Gi/QPu0x57z4EPI5F4wN036MhQ08qmUEw==
X-Received: by 2002:a05:6808:30a3:b0:4c0:9d00:b46d with SMTP id
 5614622812f47-4ccf69673bfmr2964764b6e.13.1789733448674; Fri, 18 Sep 2026
 05:10:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: arash golgol <arash.golgol@gmail.com>
Date: Fri, 18 Sep 2026 15:40:35 +0330
X-Gm-Features: AcwNN1VHTQcvJAx5UHLqFpWuZqO8u4eojtMOF-6Drot_JdeWdjwhSqVny6An6Ls
Message-ID: <CAMxPZkjojOOqT=jyX=zyzLT5-AYqL0=obJxnPKsgewfCeH+U2g@mail.gmail.com>
Subject: media: video-i2c: fix buffer queue ordering
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil+cisco@kernel.org>, 
	sashal@kernel.org, arash golgol <arash.golgol@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

Please consider the following upstream commit for the relevant stable/LTS tree.

Upstream commit bc4574c265ed738849e46d942617100580fcedd2
("media: video-i2c: fix buffer queue ordering")

I forgot to add a Cc: stable tag when I originally submitted this patch.

-- 
Regards,
Arash Golgol
