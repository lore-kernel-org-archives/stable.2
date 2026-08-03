Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432ED1CAA68
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 03:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785728806; cv=none; b=VqSQmhzxkqDi/lQuyA2NLKa4X8EVKtwLsAhXchVtxGr3DVECg0ocP+QhbqSKp7RUAXMigwmf/aYTWNe6QNwTYr8BrAzOBzimmymoJnmtc4VZ9mX5cTxEeIa676GnFhpXNbwouJHD7TGQUkngYMFNSm1LbMWRKbXdhtDaqr8DoT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785728806; c=relaxed/simple;
	bh=b3RXsthHfuRSJYdglnYqRNEy70rxz4qqHOOmXyETQjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVLB+6jH7DjqX8066RvBiQiFjb+tWyUDnwPBJXu71qAdyR75sp2zT6s46f4xL4JVjn1I1m6m6pMX8YnYIoxFW6tmPqWiGoQQ+BIAqjUwf0MP6sdccezKQTABVmaetJJb4wViuwX8LUQGeSYLcs0il7yTcYh3rcV7hvDQZRL1Pns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KR9Paxp7; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KR9Paxp7"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84eb992a881so2266292b3a.2
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 20:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785728805; x=1786333605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3SoMb2EehoxmO1SC5KL3bzZVbyyexo7yosgxBK0EG6U=;
        b=KR9Paxp74GDvEreT3F5VLYSUbU7XmXdtGmbQ+i9IZ0znX18/Wq/PJQnI1fBCODPiP8
         9/rot0SQHX6xXTtN3Nh5Txw7dhTF/Ff6swJw3LZmQWKYdFufY5CFL5cJvqMG2ILPVpE1
         OtDIATGTNul2UayFj3aDCi+KgCOJqT7/ydLuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785728805; x=1786333605;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3SoMb2EehoxmO1SC5KL3bzZVbyyexo7yosgxBK0EG6U=;
        b=phb8XsKiaANdl+DNMjke2O4HQxu+s+5eue45Bkt4zu6NbcTFg0jXpgRJlMpHrF4dzV
         bujBzH8VeyuEjaUL/ugacSmy0P2dtrPfYZesM8TxmDEPRaznbCWbFcng7Jpom3sKJ7U2
         m0CUjQoZ987fMKjaQwHJt5YjsizbM+PH10ZWLWlYB/obLomszIAflV2efGDYqUgNerkK
         oqKwWZB7thD5yu8F23Z2ncBKKUu+qJ5avrJe9TLQtkwULrPba+nBfKCjEWHW46xZINni
         Evwm1ldGo3rLAYAJMVHwfo0Pj8g5HMDwLQ61NwwnO866JwgACbJ0DN0HmhJXi4YKfivw
         JoxA==
X-Forwarded-Encrypted: i=1; AHgh+RqN0XcCXxOTs+0Shlsp2Kto43G1vTHH1wVldOBCzY02rHTQZDWWKNDRG/sTBnI5Ek6r5DaPm1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh2HNCdm/qWH/an4cWccmSzpVLLWyzVZt/OaU1RgjWUng10Wb3
	MyZhS8XxBQ6aCpth+yBSDgZyYV6N0TePifbvkUZbj8ozgbb1kIDVTs6Qu/+GDYvUjw==
X-Gm-Gg: AR+sD11MYQ4HofOtLAu2XGB+8k/mULtmgKKHQ9kakYJRAPZJNBCZXxgoR4Osf/aOZc/
	SaU+5i7w+ynJmkPxoxfq05IpcJtcSq1ghAFcug++utRb8smz6gOxwUBgkazjFjboPb98ZQNUhqg
	4LX8f1EznxKyfpRW6e5oBlsaWLmu9qkhlW1mwJSdmGkZTTz7BSGasWt2cV/VfmkYc2sE9ySfFPA
	3dcZYQj4ksJaTBHwsyI8K8BxEkGrzbeeDgWMTWF2NdXFg3KyKrELKUJAMzb3WYmhnoTkDdP7CeU
	oFsI6q+rflbZRFjyGCm2srPBLg26tX0aM+BfhVZiXpI9IvZzJe3VRff3wY+VyW1iiEYg3X9g6Rh
	BwVGgFbU7llhdnZXf0AlYJhHE/hPFOaRRC1TAZy6zoaDsIxx95pOSUwf5QBSuuiHeeEmDA9O/nN
	y9XiDFr3xpaIauIhaIa3Y2D9men43E0mOBqDnawLOMo31QhjfTbKPSLqkzlTsr6qP+GKQHq/4LN
	nDeSRGuKqhpq6296ANp4zfDTcAjS1zvuIulolM=
X-Received: by 2002:a05:6a00:8018:b0:842:6004:3fd5 with SMTP id d2e1a72fcca58-84ee48236b6mr6709205b3a.25.1785728804652;
        Sun, 02 Aug 2026 20:46:44 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:a2b9:dfb1:c4ed:ad5d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbd31585sm3056227b3a.3.2026.08.02.20.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 20:46:44 -0700 (PDT)
Date: Mon, 3 Aug 2026 12:46:40 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm <kvm@vger.kernel.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 5.15.y v2 0/8] KVM: fixes for CVE-2026-46113 and related
 issues
Message-ID: <anAOuAl2pMfRnE0M@google.com>
References: <amG2CyrA-yEUmHqV@google.com>
 <CABgObfaKqT0gMUB_XRP5DW5HmpgaoTgmD-A8_zQVG2Vp5xZE4g@mail.gmail.com>
 <amLPUt59eFu1n25z@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amLPUt59eFu1n25z@google.com>

On (26/07/24 11:53), Sergey Senozhatsky wrote:
> > It had a regression and while there was a suggestion about how to fix
> > it, nobody had time to verify it.
> > (https://lore.kernel.org/kvm/20260630223723.83727-1-zcgao@amazon.com/)
> 
> I guess I can try helping with that.  Will require some time and
> help tho.

Folks, sorry, I don't think I'll be able to help with this.
For the time being, we use a different approach in 5.10.y
and 5.15.y.
