Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AC245A2A2
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 07:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752981; cv=none; b=Khvqd0veuPKTFY4hI/8Dme2I0IHGR/t1eIbJZOgj4tRWyFomZTo2PWqxoyTnlzoteCloiU39oH4v1WasWKrm/PJNjDRIA6T7wmppbalN/sZMFHnVkln/7eU0ZPiFm9BKjnWVH0M5wDdMFy1YAIke4O78SAHL22tmahxc7qKHuBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752981; c=relaxed/simple;
	bh=W1/LVnypA/Fa1aCBl0ZqrQ5A0oO0YsvOH2E8+KStOoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4KEfmGamCMPeYTUq56snQb0w4SrghcRaDly7N41+EwGuPA38liRhZffvjewi7Y9p5Fzc2cMINsKqmyrbJexpI80Epz3k1HkN7Ren+e35Vz+GmGRhciOkpUbS9ZkGCrKcBDdAMOkdHEIJz6hGHiPbFNPdhzvUnT7f3kXJMDBzKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKgN/k7g; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKgN/k7g"
Received: by mail-pz2-f40.google.com with SMTP id d2e1a72fcca58-8805988a200so3255271b3a.3
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790752979; x=1791357779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W1/LVnypA/Fa1aCBl0ZqrQ5A0oO0YsvOH2E8+KStOoc=;
        b=AKgN/k7gRZJu7WmE05CAR7sMFeRUJdwYpV4zoLO1dk2nQhHYD/vwcBkScvpLjH/bTQ
         un0kujJq09kyFVxD9h9GY6YKyr4g7s7uqmPXuaxnj15u4H7poY5XsTcto0VdEHEpE7n4
         jnM4H0D4s7lWLr0759bTfNZ0Q+JcRM4k5baYCacVRhX62jOroIfKbJhYGTOywnX6oLmo
         toq4S/+6KbNcTQac646pt0kWhfWoi7t2W+qAcxMgVLeiSb8eFiXmK71Foj9JSosXmpoS
         0wokDnavkPeuP8cPZ88Ck8WW/HCaW+2lmU9/oZC5JKTKZ0KrBKM/GUfpdFmss45kU+bL
         jS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752979; x=1791357779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W1/LVnypA/Fa1aCBl0ZqrQ5A0oO0YsvOH2E8+KStOoc=;
        b=v7KeCPp0OfiS15c7+IXvygbK4jIev9AbuT/9xGVlv858ypSp2C6lexTo4qwuuCth/7
         DyLgIXaKz9hvquXi9Tx9ft6uaGBbbnUJhlVzu8ZYyud35vnfC+gRD4FZMoXy1QFcTI7+
         Cj8iDphlFxOzPPvlTLWw8xgxSpIHPM578edLXeuPFQwf/1Ny/+Lz7qqq+mkj4W/KnVFv
         gtL280lpBG9lSLXr3YPhJL0WiE9rUPn+ZmP8zT3m+VNPpc2bjF5Qo9mH9BP0cxlKX2mB
         UuPZXElLpI7FUbmfA+ataM585fw6hb+DPDA220yxHKLGY9Ohk+obgwfjBmVdfKm1Amu+
         uSOw==
X-Forwarded-Encrypted: i=1; AKwUvBxVYBrqWyL9jdVD0lv8aNjPEREicNaCzR7YxsYOm4d8Ia7IAhfiaVghbKgjn2iu63aiDj1q/rg=@vger.kernel.org
X-Gm-Message-State: AFuF++mWAvE3BhmBljGZuW0NK/S0XgF9IcehCYZd0YzZGMDlkLJKSeC2
	0jN+45h3FCUKrIhvsfc4r2wn0pvTHBD22Hh63i2ojXtaIxUUzaMYoJBn
X-Gm-Gg: AYBFou29T8MKI94MRLDvH5fK/nf3xNs//iMdLvFUz/C+l5E9C/0okgflFkE3+xx3OMj
	me0hbYfMirv1unkoZWCcxyP+gicrkIMh3hd/VX+ILvPcNT2QEAL9RDdbVeYKd+R7vgV38wTm+ce
	7hISJnnwqYh7j82ohZ0f3FIjqV149JobjoVtIii01FO1/0qxgC6UPvMDmS18klrgOX3/p9PNDXm
	1NbhtGpROVkEJM2AXlzG2AT9AjqimYxxgMVZBcU5B2b/AAEYd+RLKEQ+p1AqnnsxNcmNiO633gE
	0FH2m5MUUgQXwGBIOJtSyp9b+cZ6VBo9Beb5P8L9d1xEmoBdga0L06etVcFYw3YER3cUC/UqXY/
	0UyS2ErjYjHPakR9JRkmQI/9/5EC64gZwnMbX8eoILPjS/m/LGNy8qmwtnpopd3p5DGMHZV/Fm7
	AwGAKeD6dANAFD3F1N1mBFhHFhA5cce6ZhL10GzBFflvmN8Eo63Vm/K1UhVKrAD8N1+10VNFxHf
	n/B6cPzQcxqvR67TugSmDI6bpnfCoz7JM7JqRNxz24Ttxad8zfUG7CkCkqIkXFGW45u7poAZAOz
	obfRD7b7kRnNtuIUJLqcR/EjtSsZrnFdV9Nm6gjqYrf2ctJ4aXk9a7U+I70=
X-Received: by 2002:a05:6a00:a253:b0:881:fa65:d507 with SMTP id d2e1a72fcca58-8874ab8ca2amr312784b3a.22.1790752979389;
        Wed, 30 Sep 2026 00:22:59 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8872643903csm339794b3a.44.2026.09.30.00.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:22:59 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: Anders Larsen <al@alarsen.net>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 5/6] qnx6: abort mount on superblock magic mismatch when silent is set in qnx6_mmi_fill_super()
Date: Wed, 30 Sep 2026 15:22:55 +0800
Message-ID: <20260930072255.1167805-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930031604.70544-6-benquike@gmail.com>
References: <20260930031604.70544-1-benquike@gmail.com> <20260930031604.70544-6-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested as described in my reply to the cover letter.

Tested-by: Matthias Goergens <matthias.goergens@gmail.com>
Reviewed-by: Matthias Goergens <matthias.goergens@gmail.com>
