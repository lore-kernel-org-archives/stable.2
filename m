Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748553597B
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 00:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783644346; cv=pass; b=MKjct13GV0SlycQD7dL2FFyLf+TN/eed/VVHOvGSzRDwu6cQ6T7noy6SAsZqu73YArNF9b1e2zwLbrLzPMAGY9CUkYcFChyxGvfPlOBkEM3RGAp6u7/0kATNQn+bV7+Nwq1sJ7lMxVFKJB0o25fAU/ELeGvXSBSdTpXM+5l5t+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783644346; c=relaxed/simple;
	bh=cEFXJr+q+9MWtcGTtdT+TqhJ4Ycq1/vL6B3e3GzFB1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4AOHSDy2oXCykfZ6mrDL4hKcgIqhqOHmQfo7P7GJ8GsSq0fMkJguMMtD1Tyidf+kM63j6EBWn51k/Zf9RUbdA2/0FUupNDdcUkuF3Ywgc0MgtuOcW53vaagH2Vxb/9Sx4T3XHve4DeMUfj8tWfklIdv62Mwp9EObqt3JCpHBh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fbAPyET+; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fbAPyET+"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c10e86e52so81011cf.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 17:45:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783644344; cv=none;
        d=google.com; s=arc-20260327;
        b=Djw+wP/jq/3AX7yfDZhMERi1eICaJWfNUC9RoSoRnJEdrHkXZaDH+iHfxSsz8GaalD
         i+//M5MuykwrywzJmkfCBCj2hR7LdlFVVJu1mviOyzyCU4Sbz9Zqv7h4DVZ/h5OLKoEp
         v1+ZX179txBj2aeFOJiAtfUE9PtesmS3Gc3X2kldHIzCFxGjMMSwsJu0y5BTHdkddBkI
         yO/MMdDDCp3X67406mpSCtlzhcgCnxpdhK1uhnGklEMlZRd+TpSDglXtzcIAKdHhVTEP
         xcNOZHAaKGdBV8AB5Aj8e8dNkQRjkdWIDQGbF/asy1oPW8UBfg6E04xp27EAZ42b7XKQ
         wDMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4NDxZOCfeqZWYG26A8bUT8OjQGBJjjUiBg2MLvfAqRA=;
        fh=eReSlhDXvuO+ksANufpUBMAw+nuInSX0eqD77sw96WI=;
        b=dt+GWvQS602RhwnZo8PlLVFxcgb52rQ6J6JcZgk7wWnT18rQGUbQY7jNNDLHceh9y3
         tJv+2RGcT8guI7/kf0UJHvZPkiNAHANTTRGv9lYJ+CVtatIFrLJNVBlNYqDURFtTkN1V
         vtY+j96Rxh33jP3CAaMIKvUzdlgwpBvUHiVLQlzSFJBWfnpdyEAlGe+WH36FyHFTZlCF
         VVf8cjUk+Y2kr3LT4Vzyv2yUXhP0mWsWMiuAttnW04kX5kt7k0wSNTukaIoY3NyX+qp6
         FV2OjJ+H5BiEjH2tpdGt+QiamHOwREVmu1DX59dFxu4LgBvcqExmLfLZsP+MzteSToQf
         f+MQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783644344; x=1784249144; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4NDxZOCfeqZWYG26A8bUT8OjQGBJjjUiBg2MLvfAqRA=;
        b=fbAPyET+PtpwEEMaPxt4ABk+7aQHBJmphNZil6X/P+j/HGpyN0MMJxDAnLMWol7DpW
         KtkWGWX0vBaD93IwDhzV0s9TphrbjSBkY5cjpTYMhm9nAM9dkWwU1bCa+2gcaG73LfDq
         /Zu/zTurim1JTuo26Gdg9R2VsZInQ2N6rvR1rSy+AM5P/5QFy0xxIlnwi1mX3kpwMX5h
         uXdg16WIBX9W/NajtHTP6shqwZlZhCBdE8hHb0pL+ZVHoOCazW6TlkL4xWhQ/xmHbBva
         O5p8gE6OpeTdo3S0QTu1RPRprw2pvG++RDT1iQ4gIkkMQUWSV/JFRjgmL8RQinBjYf8M
         HBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783644344; x=1784249144;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4NDxZOCfeqZWYG26A8bUT8OjQGBJjjUiBg2MLvfAqRA=;
        b=PBzzR+5V0QcpFfRmIY7FKJOMXRJPEQodAzUAoPiztkrSSPWm5rIyIDP8NN6CFAhgwV
         ke5+iykrzZq+J2blgLrqwaj2D+QXPmWygUzdj9LyuzYdsq8lGgRnmIQ/+9CHPL7nfsPV
         aW/67gxn+oG8vEk2gWYI02Scjc00YQvIFbw+dVpKh5oRu2FmS9r0qlR/wDkDrH1BnGZN
         npketTHm0uaYWsZXrtuckMgor839gVdodapWDvr5s06iydfL87KdOJu0oHJWjwUAo3Pe
         IBCo5lGUXHJ3j8dZnk8GTYT4u7+iyto+HFKTX3Fi5kTJAXa2lb0nn2uJTAtSV7yCE4Zu
         1tbw==
X-Forwarded-Encrypted: i=1; AHgh+RrkOumLDwkwvyNJFFE9CB2WbbpiMIDRughazegZpmapBnJuLBs1FDBqMfPWa1o2X76Gu7Qr7Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya4EPq3R/NfOgTF61+2jV3qFADwBXl6VJL+CP5Xiz7UMeT8SZ4
	msC0Wy2tCMr2HcT8HBuTRRfAKYOZreR2321PPHLQhrPt0fn9nT/1prc6yl+dvrZB4uPOaO3XYfZ
	0ZbgODW7YIwcZHtHcP3fDpYAwLf6n8ywan7YMVBNb
X-Gm-Gg: AfdE7cl7GI/I304ALPmSwul5JVarIQjTzQqyBwx96gLZsFRPY6VYf9JV3rosPXL1Rgn
	Keed1y8WlbapRqgdiOjFjW392FHyopMc3nSiDNA4iwGNN7eyElhSc/PndR/oub75TTM1zejsqIC
	8oMDKw40DXrcivkypyTQWIpztDG9T7sRXbIJlRlMbK5U6n0BB5eNUnv6+TIBskRf2zfDmOJya7a
	keFiJvjJvVGC6FttcpRU+V+HKnZ57AVcjLo3CwaZFwLb+6HY0jLg9C4CPBeuW8WDU01SMR1tp/b
	egHuFxFaDYxani649IPpr3Ej8g==
X-Received: by 2002:a05:622a:1f09:b0:516:d570:82c0 with SMTP id
 d75a77b69052e-51cac54df32mr2758731cf.15.1783644343839; Thu, 09 Jul 2026
 17:45:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709224330.946683-1-linkl@google.com> <20260709161253.6b5e9ba349f70a3ebfb8180f@linux-foundation.org>
In-Reply-To: <20260709161253.6b5e9ba349f70a3ebfb8180f@linux-foundation.org>
From: Link Lin <linkl@google.com>
Date: Thu, 9 Jul 2026 17:45:32 -0700
X-Gm-Features: AUfX_mzRlthWGS4tvguyuxlqGde2yyyYF501igG6ylQK6FfQ-MElEO9rT5w6uEI
Message-ID: <CALUx4KQ=bYTpDoDAZ+iVb7Ehaa0LmyPDsEWk3xFFmTVYKrpAUA@mail.gmail.com>
Subject: Re: [RFC] virtio_balloon: fix Use-After-Free in page reporting during
 PM freeze
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>, 
	David Hildenbrand <david@kernel.org>, virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, prasin@google.com, rientjes@google.com, 
	duenwen@google.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	Ammar Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com, ahwilkins@google.com, 
	Greg Thelen <gthelen@google.com>, Alexander Duyck <alexander.duyck@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Jul 2026 at 16:12, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu,  9 Jul 2026 22:43:30 +0000 Link Lin <linkl@google.com> wrote:
>
> > Fix this by:
> > 1. Unregistering page reporting in virtballoon_freeze() prior to calling
> >    remove_common(). This clears the RCU pr_dev_info pointer and flushes/
> >    cancels prdev->work on system_wq via cancel_delayed_work_sync().
> > 2. Re-registering page reporting in virtballoon_restore() after the
> >    virtqueues are re-initialized and virtio_device_ready() has been called.
> > 3. Unwinding virtqueue initialization via remove_common() in
> >    virtballoon_restore() if page_reporting_register() fails.
>
> AI review thinks the patch didn't do the above:
>         https://sashiko.dev/#/patchset/20260709224330.946683-1-linkl@google.com

The AI reviewer might not have parsed the entirety of the fix I proposed.
The patch submitted definitely includes the changes to virtballoon_restore()
for steps 2 and 3 (re-registering page reporting and unwinding init_vqs
on failure). It seems the AI failed to parse the diff correctly. See:

+       if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
+               ret = page_reporting_register(&vb->pr_dev_info);
+               if (ret)
+                       goto out_remove_vqs;
+       }
+
        if (towards_target(vb))
                virtballoon_changed(vdev);
        update_balloon_size(vb);
        return 0;
+
+out_remove_vqs:
+       remove_common(vb);
+       return ret;
 }

> It also might have found a couple of pre-existing bugs in there.

Indeed. Regarding the first pre-existing bug found by the AI (leaving the
OOM notifier registered during suspend, leading to a UAF if memory pressure
spikes during S4 hibernation):

I actually addressed this in the commit message:

  "(Note: The OOM Notifier and Shrinker/Free Page Hinting features suffer
  from an identical lifecycle flaw and are also vulnerable to UAFs during
  S4 hibernation when memory pressure spikes. This patch focuses on Free
  Page Reporting, which runs periodically, to ensure clean backports to
  stable kernels)."

Regarding the second pre-existing bug the AI flagged (leaving uncancelled
works on system_freezable_wq if virtballoon_restore fails on the cold path):
the AI is correct that this asynchronous work cancellation failure exists.

Since these are separate, pre-existing lifecycle bugs, would you prefer I
roll fixes for the OOM notifier, shrinker/free page hinting, and work
cancellations into a v2 of this patch, or submit them as a separate patch
series to keep the stable backports clean?

Thanks,
Link
