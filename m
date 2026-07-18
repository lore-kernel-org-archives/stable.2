Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD120312832
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 23:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784418609; cv=none; b=YgmyXYfA/35eSVr2lkB4Oe6XbdL5AYl2dzSlIlJGOQEaSK1hGyM3+ukVwOWKdcXjQCdHUzlxLKOtdRdvZ3QbewWEWsgx+rT3v6HeFh2ievWQm+/yQSjLMBuEemn+K+OjkEjiWlRRZGXzc/VF6HyffgsjYGd1YjDupE2bhlyCIV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784418609; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eii7O+82MnnxsBybXoQq8+VX2IfpzWsgxljJ9DRCO92hKy1AgFo99lCV6oRydXcIM1dfwxmB/VvhW9BVoSPBFsjfCPk+3LkWkWUDIcbqFMcH9LuZifgQRSS6vLfw5RR/OrWJe14ssChcKhc9oyEUJw9lq5DulMGZ7Z+riICt644=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iH9mkNTY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TJORIRuM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iH9mkNTY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJORIRuM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784418606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=iH9mkNTYSPoGbD08Lhq3f/+b7nwIZ3Y/xxMJPbtBfRfyiqJlYM0n5aXCj+OryKQWFb22Tp
	Xsz3SSjOkciUluVQI366pvZ7XJZO7K7ie4oTJlbxRcLeilFl4sr1UWL+cyYARgzRh5Zkyf
	X1icpm7ZTMMzLotRCucEj7dkHrS1axE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-2OifyfVgM22mieano5gQ2w-1; Sat, 18 Jul 2026 19:50:05 -0400
X-MC-Unique: 2OifyfVgM22mieano5gQ2w-1
X-Mimecast-MFC-AGG-ID: 2OifyfVgM22mieano5gQ2w_1784418604
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f6d70223dso456639f8f.1
        for <stable@vger.kernel.org>; Sat, 18 Jul 2026 16:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784418604; x=1785023404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=TJORIRuMuVR/PM0iM+dcZxxBrlNGfDjBcwKV5iBI4PkjKFC+1lrdtKhfrkVS1vSfwU
         SID28urmvB6F8hZDVUqt92o9fmQVTINb3WUeoG7CxSS7ATz8F6dJhScHwlcriVrtXKlM
         fyQThVeABicyIaej+mFOzNGUa0r7j1AymCGx/CfSaa+hsZAa8kjsKo3GdCeFHJBh82LS
         iFq+jyOJONXXPzCywV2ldl+4lnzyreoFwXku30MOBBLBIvTpWKEdL1h8+7Q+r5hkwJxz
         8ib1Yz+F8Gt1xHRXQ+afoWafuuq3t9hMzm1Rwy0Ucm+nzxaDq3IajHrggn5GYrW07Ri+
         jOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784418604; x=1785023404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=X9+oeV1Bsoxuf977KNwI2B+Hoc0Ve1p7bx0JO5D6iJ6M8BVh+wTkcTkrZzfSwqPfdJ
         fc4K+hsRDvDH8CkoCXfYJ1bpEbYeLbWC/9cPtho+R9w47j8UGXz6tvG5HjINlroJHMlP
         RchpzzLZFx11WN1y58/zUvVjxEa2yKEmKXhoTl0a1zlhdWpblNiPtN4IEustG3vbujnE
         HKSdPRT7++2NOO0ZbK+WetoxFJjW93z5ft9gUIP5GuOxBwImC0VSisVd/mXniL+bG6yz
         AlFVm1aWWlDVVjvCx65g8t9MiBTOXK30qHKNRwuewUQxZdGCALnnObkC4DK6hR7rZ8pl
         BWkg==
X-Forwarded-Encrypted: i=1; AHgh+RrIwaDHZmBxdD17HwFKnZ566A3Ri8+d+IE1e9kI7b6jOrmR/ZSy/QSBv1XAh8AsefCJQ8gmA70=@vger.kernel.org
X-Gm-Message-State: AOJu0YynVv7vlyj9vm1R4kd4KgC0IQZoQuzJ9jHGNKbScvNO48HnBvWH
	7mxOeBtOU0sJVL6eRhTVOx/NYiX77ZpkJZli0+Sx3pvak+HJJ6L9BxlPq0KLTx6xEVDWi79UdCu
	e3fNmt1sX7p5D3GwX8iQSoW7PY/2anvvyj6212w0GJuKSCC+rCSPvwCy/qg==
X-Gm-Gg: AfdE7clMc8T2T/QrxSWDm+YLclRx+62VsL8fgQSk0TnOYw7nse5rl56ea8cnQvpWSeO
	enLp7Ttoa2FJJdzyoESploZMv9jdO2JmkO6kZfQ2cW1bGdpmOa3Mg08DNvIGRf8+IhAx3AXdSzy
	VzLo80XDI3qqv0muJ0hVfBdVf3lkoVArnc9oFwazZzir3/wWxCxtZBJPrsyVMpON4eaHTnIsZ4g
	AgPLZpvsE1qmtut+6PzbwgToZW39UOUGH7boWPzIFr44jEBnGv265ME96PEOCLgZ6vi3H64DYvo
	CC+zU9urwvi1WNUe4kKSEwPqq/Ec9rqM8i2V1BmkzKBncSOn6pUeAvE837lLdk957X79EivMflE
	ZkP1NVniaW4U04vxtq1FNvTbBzMhMiAuW+sBrSzB9htIpXccdZ50EwppSiJvZLH1kAhFeZJzfAv
	wkk4A=
X-Received: by 2002:a05:6000:3113:b0:477:47c6:36e5 with SMTP id ffacd0b85a97d-47f6230dc46mr10589675f8f.25.1784418604216;
        Sat, 18 Jul 2026 16:50:04 -0700 (PDT)
X-Received: by 2002:a05:6000:3113:b0:477:47c6:36e5 with SMTP id ffacd0b85a97d-47f6230dc46mr10589655f8f.25.1784418603681;
        Sat, 18 Jul 2026 16:50:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.47.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e52f81sm16841322f8f.9.2026.07.18.16.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 16:50:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Phil Rosenthal via B4 Relay <devnull+phil.phil.gs@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Phil Rosenthal <phil@phil.gs>
Subject: Re: [PATCH v3] KVM: x86/mmu: Fix use-after-free on vendor module reload
Date: Sun, 19 Jul 2026 01:50:00 +0200
Message-ID: <20260718235000.50192-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260718-kvm-mmu-cache-uaf-v3-1-e103b93c74e1@phil.gs>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued, thanks.

Paolo

