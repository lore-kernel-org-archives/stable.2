Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13E6472084
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255099; cv=none; b=VctOBWfcDz6Jom03mclfhGh5KRBnmX+A4mkSnxVN3yUekxaKZNQTyZH0SzFFhRXYHEFuNeGdMMN4QTD73HjEk7Aoi2aDybR0CrF9AH1csKcS0AZf7ZBNAisTsInmXXVWc723Obv8CzI3Zel0PYPlomgkotOhfRyFlWYfHunJjLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255099; c=relaxed/simple;
	bh=jl9D4HbYtt0iCvxNDHgV3gzFDkORtqHa3wmJR3iNSNo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b4aFg+35l7wu/sstyZRvfvkj9gdAafAYQOwa1TbW5C2BQBSMW7/iUsyyAJn13CGEOEZ2ze1RyuDTRYXxJkE8YzyyFffi+rN+G4CsCQ/3HB/OpGbgOWf38CNCUuTeYz4PkRfzVu4xIooodRLPJt/hXEibfNWJZ4gJNmvc2WjiugM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YgqCR5n0; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YgqCR5n0"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49ccf17d3b0so16430125e9.3
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 02:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788255088; x=1788859888; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s/fiWQ63WImRaHU5MSJK0Js7QMO+oBpUYF5cl556nCw=;
        b=YgqCR5n09fBrW7zpDuji28fP8w1S3eHOxZzo4QVSz6U4fz1x+GnNUtF6rr74E2yD5H
         vsrdpoecqPHozyDmJyPWRVAIA51JS9tXUXRyzJttCyZEEK0dW0z4kUT+tN+ajxwhnrFg
         dITmEN/by07cVGJCqb/O0T7G7vlCIUq61hL/8LKR7Z7glwqCoPhnFrmFbR6zaorTs112
         UNlVglqR+au9cWvX7sAbH8WqtrLwhmThapJvJUjwm5P+I1PGL1Vd70Fb7bN4ZwH+qDYZ
         O2Qc8gb0LeakJLqi91CHZgqqHFwthbt2gndvFAvGhdrKSrZ02RQcWCwJt8nU9CB7w3V4
         npsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788255088; x=1788859888;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s/fiWQ63WImRaHU5MSJK0Js7QMO+oBpUYF5cl556nCw=;
        b=B2LfL/1U37c/h6fxrcJWFpdHlo6LAJqebzh1fST4V0/14Ft/gHWKbBsadBHxEtPeML
         oFzQo6UhJ2WAewEaxIhiUetPB29XOonolpwUNIFWNF+4dgfRiOqPFRDX/Mqv/ZrgYD2X
         ospsliuIjnlr3IF10i7CX7hd1IeaGamzubt+Me+toti70PCR0Ubp/CShBO+zkn+4zLDR
         0ei7+qgOGaIcH5ozWuR0JM+CDIoNPmMW6B0Pc88KdVh9GWhxBjnYtXUi3MKFb8URG38X
         ZJ+jQFv1+5XOiEzO4hLIukAj67ds9reoFat1/jAivZX65heJSJVK98tlrnsS0SrqIiCY
         lKBg==
X-Forwarded-Encrypted: i=1; AHgh+RoqCYztLCjTbdKx1X8uifYFeh6bfEoYck/N7DNuimxTUUvIW6TwuBKOkRWXEl7yO6JJwZFcaOk=@vger.kernel.org
X-Gm-Message-State: AFuF++m2BHhEMW822uymBgtEHUTjPDWUkW4XFDKdOrcbrRIEjNepEw0p
	Mf3Sz7cUeaUmTzRReVoarfSbri+gS1bLMDbqAD6+Y5l0VEGupHBZ8sH/H5v7f22aZ1R6D5M+pYy
	ZEOEWl27e9kOBcw0LTw==
X-Received: from wmpo25.prod.google.com ([2002:a05:600c:3399:b0:499:610e:c4b7])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d99:b0:49c:cee0:e7c0 with SMTP id 5b1f17b1804b1-49cdc560282mr146000615e9.16.1788255088208;
 Tue, 01 Sep 2026 02:31:28 -0700 (PDT)
Date: Tue, 1 Sep 2026 09:31:27 +0000
In-Reply-To: <20260901030419.470246-4-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901030419.470246-1-cmllamas@google.com> <20260901030419.470246-4-cmllamas@google.com>
Message-ID: <apabb4vGhNfcXMnY@google.com>
Subject: Re: [PATCH v2 3/5] binder: check vma->vm_start in binder_vma_close()
From: Alice Ryhl <aliceryhl@google.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Tue, Sep 01, 2026 at 03:04:14AM +0000, Carlos Llamas wrote:
> Certain operations like a failed mremap() might trigger vm_ops->close()
> on temporary mappings. To avoid tearing-down the main binder mapping on
> these, let's verify that the VMA matches the expected starting address.
> 
> Cc: stable@vger.kernel.org
> Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260831224145.169403-1-cmllamas%40google.com?part=1
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

I don't quite understand this. You explicitly made sure mremap() can't
happen to begin with, so when is this called?

Alice
