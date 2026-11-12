Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487121;
	b=SfBuiy0S5VIx1yrsrRHBirJK9eHl9Y577PFc0CSprR/HNTUuaS3z/wS9KyozBy4CUy1H
	 LTd4vVjEeg16k7eNbDyJRycLHFv6oGVecIxvJ119gVJAENwAGWaSCrXaknBRWXASaVcC5
	 i31/WwjsKwPHDR18NyBmEONzvPPDogUv0tVO3i26tct+U5CSM1bDr8xfPVzo5d/vMoUDx
	 YE8751vI1TcIlt7AOf7fMGR+yEfYiJ14NizK5HC+Y1mbtf0jRBacPfuwEqhOhTPL50nqN
	 8i9qgvvjD0AKDaLprnvNVFO9GQzKLj+RgBwHFyl3c1ZTj+Za/QVTt/QUJ8gHNdWyaOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=6UK6/KKi1vmJaH5c+RsMG+pBls/fTxRgXLxWMTuXdtA=;
	b=IuiJ4ZG/qcNygg2bZCgudi+CUldf4HQSCRdcIvLyfnB4jkb+xGE7zNp9hZ/kq3X4l9EJ
	 30SzdumknvJ/SeYqCWz7RJlS/Pnf2TQbMSM9dHx6cGJrjmWEMYkKtSR+s2lFyUz78q3YC
	 zKlXBEQfSSLbjSqd0LFL3dRvUTJSpV9B+KNarHnvSKpV3lP+9ihheIsezVqMJLN+hQIF8
	 R18hR/hEJPMYFbj2qi68uwyU8MEqyQKUeqotm6UW66Emquf7EiRdSizSxWY/s51wpOxfD
	 u6c47dK+zucgVP6qJawZLqonUsr891ONV4pODcaKoryF+7+P4aKD+u+4uzhTHpCFayg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--chriswiseman.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="K/XrF1+5";
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1EA606A323
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 12:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F1EA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chriswiseman.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=K/XrF1+5
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36de26cb4b3so5398291eec.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 04:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794487120; x=1795091920; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6UK6/KKi1vmJaH5c+RsMG+pBls/fTxRgXLxWMTuXdtA=;
        b=K/XrF1+5uQeap9pI44P2RPX4tS2GuaNG9a3B4XiYyNz2g5kYkyS1mb6fEnQnNet0/r
         8Hdb1SoLF9wDC9aBHqNWb+evQNYbf9k/eOZmSo6tZ8evUUZnWi2e0Xn6l0CqYgFyierW
         dTkswGclAbjt/UzUwT5OUOLwjJhg2O2Pg7K+GOdO6pciJPqXixIPbzVOPaFNVYBNUt2p
         /8aJJ8i7jPVea41VNU2UVSyiVszV/UHnVXNVHfT0bMbgJHME8xFBCytunzLSl+XGW/uT
         qENQCu3U9Dz151E2bpyakraQOj21EMCH/RLVb85kJ1EQsNIU9yrhxvBwSlJVvUrIfyr/
         t+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794487120; x=1795091920;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6UK6/KKi1vmJaH5c+RsMG+pBls/fTxRgXLxWMTuXdtA=;
        b=xoHIU6AAQA3aBR3CHC5PJ6Jj4DdwqxHjcWdgX//J93jZdy2cw6olX328j9N8Jw9Pjf
         3HTNAgmMxa4klJMGxc0E3bJgBmR3wQHnSLuXhv6GEu+xuu7DuXVEyLn/SNDWJtRLdS7N
         BrC9fVJSvmzktTLHeH9jBtK5udVcpd88e+3Z75qhYs5eHoxF8rDlOT3gZzA2FxF1FdlZ
         5hSBOHa/BWkq1M5TrPnd0yKjMd74AuggnX81ugfPD5aXwbSDBbFPbjGpIXeiCsUMhVoG
         DAW6xabQuq9NIngVFirj39lACbrrNnKE3iTt0jGrt7arN1pOd2O+vPFa5bpMJzdnlZcA
         +MTw==
X-Forwarded-Encrypted: i=1; AL+hErH3QgACuPOT83zaWdinuW4vwoCZkLz5Z/5J5mcCi5Z5dmxfxjlI8Ew26ihNh3dZ4vjLSwVwVkg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+sbuxykSKkVBDLDFCWH9klNJPbsoLv6Gv2nGOE4M+C6sKzxkpe
	NTcune59TgitlIEXK0qdd7YRLx2aKgi1Z3WzGV5aOpQfnfzJHvEy4DX5nKF5xg/VaNXde/nOD3N
	RL3FXgXXgfTNxMUYGqXTrSW34n68kWA==
X-Received: from dybcr35.prod.google.com ([2002:a05:7300:aca3:b0:36e:b3e6:ebe2])
 (user=chriswiseman job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:65cd:b0:36a:1807:75a4 with SMTP id 5a478bee46e88-37686176002mr6158828eec.20.1794487119392;
 Thu, 12 Nov 2026 04:38:39 -0800 (PST)
Date: Thu, 12 Nov 2026 12:38:38 GMT
In-Reply-To: <2026111212-unearned-strike-a7a3@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <18e70d7c82c722e3.3137322e32332e3235332e313736.191fb9.0000sendgmr@google.com>
 <18e70d7cbc2831c0.3137322e32332e3235332e313736.1920de.0000sendgmr@google.com> <2026111212-unearned-strike-a7a3@gregkh>
Message-ID: <18e74c87090a4d29.3137322e32332e3235332e313736.1e2278.0000sendgmr@google.com>
Subject: Re: [PATCH v3 2/2] rust_binder: account for deferred work size in Thread::read()
From: Chris Wiseman <chriswiseman@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Carlos Llamas <cmllamas@google.com>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Chris Wiseman <chriswiseman@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 12, 2026 at 07:26:30AM -0500, Greg Kroah-Hartman wrote:
> These patches are not "threaded", what went wrong?

My wrapper script around our internal sendgmr mailer failed to capture
the Message-ID of patch 1/2 and stamped an empty In-Reply-To: <> header
into patch 2/2.  I fixed the script so it fails closed on missing
Message-IDs going forward.

Patch 1/2 is here on Lore:
https://lore.kernel.org/r/18e70d7c82c722e3.3137322e32332e3235332e313736.191fb9.0000sendgmr@google.com

Let me know if you would like me to resend the pair properly threaded
as v4.

thanks,
chris
