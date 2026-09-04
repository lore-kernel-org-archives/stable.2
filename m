Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA91E4A3D55
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529644; cv=none; b=SVD/CzcbsAm7Rks/EEe3ieRjKsZl751GBkQf2pvYLDF3FZERpn1hESdhmY4sbJu9+Iuf0AvaZqbgsf2rNYA92gUAP5AAweazceVEqbjXTo5LMHrZOcW9tHfEEqfQr2F8k1VDvVkrKolP98NAeIW/cxzMl9l4I/ae442hd7Ip+cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529644; c=relaxed/simple;
	bh=O7Ae5D87i6EI7b4HNf1IjlmiDF9oQSp0k5LJh9Kr2FE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lRzOmaGCoSF9DiB+48JFJiG90Wv7wWxRr4arnlRaHjA3rwXgXKoivj/4wLCWw/U0umH/lnXhqbgpHUkwDbLS0dVJAu84a4cQ81jkzq4pdvOLzJxjj/b90EYfEbql/QhFyuf/SFZi1m+MyoTTbpH1BDU0ivMWE9WJm2LE5dRB9Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LFax9ff+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Un0nZhks; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LFax9ff+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Un0nZhks"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788529641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uXuEK6XHWm29s0oMDn6W19hPa6YX2z4mhfCAsSa0mzs=;
	b=LFax9ff+fBUq2ndP2ZMcnn2x2+diW9vS7Y73ZP4VCzfMASR34jDLNsKqsJv7cUDhefBozT
	gakFALGvCrCSnq2dbDBFLN3f8K0AwDmx7JmLE51jdyPN3YB+bpYDQU6ImqtvABud5dXx8u
	8FPkfQGV/2i0LDQHouLAg5pyxKeoCzQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-7ljM-NGYMjWS8Jp-nBEWmQ-1; Fri, 04 Sep 2026 09:47:20 -0400
X-MC-Unique: 7ljM-NGYMjWS8Jp-nBEWmQ-1
X-Mimecast-MFC-AGG-ID: 7ljM-NGYMjWS8Jp-nBEWmQ_1788529639
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c16711b9473so90210966b.2
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 06:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788529639; x=1789134439; darn=vger.kernel.org;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uXuEK6XHWm29s0oMDn6W19hPa6YX2z4mhfCAsSa0mzs=;
        b=Un0nZhksNkKV2FIIDbgHwCt1Wn8N+UHH3yoC33moIx5VVfhwdlw/V6UuPrLjNwxmkA
         1dYEDI5QNlr71G6mEr6HCa/vSMorAlSJUgXGdolpLv2q6HpabtZMiGyfV6EoR0utJsQV
         Oz2DRMxWQVdWRbxUVri+a2cgMUzZ40Wzua7z9QcRIraKypKDYISOy68GsvRH+uoCcM5c
         tKLvGVFSpKwL+UC7OTVO90Swtda06QOuR9GqQIWfk6KFDN021UExcmPHL8WgqaLwBqbs
         K7KmkgLGN5aTCDZtY2Hr17zolA8ZMyjA1tpfc0s9dE4jOXa8wr8j2qxXZMDXgmySZY6x
         VQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788529639; x=1789134439;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uXuEK6XHWm29s0oMDn6W19hPa6YX2z4mhfCAsSa0mzs=;
        b=sn5L1+7a7kWvZNISmPMgvJ9qPjfQ/rel5UnKNqJSQmFU9wYCX1DXZn7hNSzUBJHVzD
         7mOjYfB+kbGWtlorpggALfeZn7JcbB5BpWIMgxDyXk5eXupBfOPKUIV/AKot4I5pBBhS
         LtaWvynXLka8mxO+pxyngxaX6IACZA6Bo04Vi3IW0bMSjs7OmfbnVbxassjv9FdovSnn
         q39IHdnuBnZ9BSgccZfbqUED7YtgFau5u1z/EjYBxMk8Cd9qcDNWDXerIbuF8gSWnGDf
         Tyv1wubRDFX8DdZFEfj6ou7E5jURGSXlcYBGwoTdJAdCylfKvU5R3MbSHpTrx2j8cAiP
         iu/A==
X-Gm-Message-State: AFuF++nJQw1JfFLpcoaD1DSFS4yQsK1jzwtRu25X28S/Pg/zc/FnMBmF
	aMeaR6Kg/VtdmIE+6HqTXmgEbwy7PjJe0uYKW9dwrvZriO/hityOSC9i9LXciUfVr5xiXER5blj
	sP2YfrWU0jSHGBbal8iuHlhrj97pkcq7xfwBMskR0Tl0bFinm3yIxK3HoBQ==
X-Gm-Gg: AYBFou1V5GW2Cf7D9mkPeHPVTpkHyfWoJ3zLFnZKhaNeJnwJf8oiF0pgVeNiyVBCWRO
	5gXUM1hwIJV6D1GOaKuDPnPd/RMa1WxCsh17CJwLDdgDDbJkDfTh2y2aT2riXB6Vr8YRT5RM4dd
	q0QxCRZ9CCqfxPPK92ZEq9R8tqJcO+Z8wKyhhpyasYEqwSu3rXJevxlIyP6/cQF0igC3n/lxgPP
	EKLklNSkjbo7WfoTy9BsajR5ZZTZGNTaAoNQnHjjXrYU3T9ZRBW35BVkLP96WBetrfBK3YcrfHB
	FYo7sylxV1KVUuyyGjgYRbLYNgqrPk9R48RdHcgPZnFmOMFSkk/EFKFyShY4/psoeJDH5moCcj4
	4AR3ZYVXS/rL+/fNimXMlDXlfWcjEDOLcJRPfVoDlXHE6rjFj
X-Received: by 2002:a05:6402:44c4:b0:6a5:f814:2278 with SMTP id 4fb4d7f45d1cf-6a7e8d25c02mr1925310a12.2.1788529638964;
        Fri, 04 Sep 2026 06:47:18 -0700 (PDT)
X-Received: by 2002:a05:6402:44c4:b0:6a5:f814:2278 with SMTP id 4fb4d7f45d1cf-6a7e8d25c02mr1925287a12.2.1788529638449;
        Fri, 04 Sep 2026 06:47:18 -0700 (PDT)
Received: from [172.16.2.95] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e6c1bee2sm1212418a12.29.2026.09.04.06.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 06:47:16 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: stable@vger.kernel.org, Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH 6.12.y 0/2] Backport
 'openvswitch: Fix CT limit teardown use-after-free'
Date: Fri, 04 Sep 2026 15:47:16 +0200
X-Mailer: MailMate (3.0r7028)
Message-ID: <4241F014-F377-4468-95AC-37DF33E2D206@redhat.com>
In-Reply-To: <20260904092810.1813221-1-i.maximets@ovn.org>
References: <2026090349-submitter-decorated-2272@gregkh>
 <20260904092810.1813221-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Reactions: disallow



On 4 Sep 2026, at 11:27, Ilya Maximets wrote:

> The patch doesn't apply well without the previous kernel-doc fix.
> It seems cleaner to backport both instead of modifying the main patch.
>
> Ilya Maximets (1):
>   net: openvswitch: fix kernel-doc warnings in internal headers
>
> Yuqi Xu (1):
>   openvswitch: Fix CT limit teardown use-after-free
>
>  net/openvswitch/conntrack.c | 121 +++++++++++++++++++++++-------------
>  net/openvswitch/conntrack.h |   6 +-
>  net/openvswitch/datapath.c  |  10 ++-
>  net/openvswitch/datapath.h  |  26 +++++---
>  net/openvswitch/vport.h     |   9 +++
>  5 files changed, 120 insertions(+), 52 deletions(-)
>
> -- 
> 2.55.0

The backport looks good to me.

Acked-by: Eelco Chaudron <echaudro@redhat.com>

