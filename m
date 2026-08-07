Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD853A3E68
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119177; cv=pass; b=cyzZlGALvf7iZcQ6hhq7cWK7WoCkKE7ioLU+5RoJpEBHaDua4D3DPE1FTvrRSyeDDzg/+N4C1fK4biomZRZvC77BAJMRTVcABlh9F7497HEmZ4fBduNofBm73hDoeFZT4Bmur8rlqkEFXRxjGKlRGEfSdBOX810z5LyOZMhtyWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119177; c=relaxed/simple;
	bh=DqtMhpwA/bXvSFLAjWXp70gh4lTUw9Mtkk9TbVJbvlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5mfrAbCfd1GrS7xTbp1MPEEARDxCQrZH6OJwB7XyZ8/KbBO4TyZk9uJnxIY9UFEJcB93dFnZ2gfc5M08WjWMUI0EnAvSWuGN3Q+ewDsrh8S7GhQ+zM8oHcZdSi7HHplfgHs2m5BAB9Azh146qBnKnJ2MvRT85XXSKCC0lGbDdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n2jyX5lh; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2jyX5lh"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81ff017d420so31870517b3.0
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 09:12:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786119174; cv=none;
        d=google.com; s=arc-20260327;
        b=GS+kpnD8bkGhntlNM6LLYH8rInKJg2cVExFpqDkaJPBHJryNic63qIYskv4y/uWklI
         GJzcGZNTQiSEwBkT4T/EnB+WBuG+PPYYMmoW9K8fGBvRBnv3sDkCXCRmzsC5hNuuO7+/
         Ii7yMZUreDw7QnCy7m4tRdMYCR4FQYhVYT91v96b3V8v2iUxXJ02tXGeiBuYoqUUkHgJ
         rqV0i0klIBbp/GX4y9S26X8VNgJIJrhg9zDlkYYuyM5RGDb5a4/sbdkZXTqhQ/+CGHzC
         qII2L6zs/rUWKV5OCT2uX9/qwOgirM+j52ilVECAKPZFvt2dH4mxDx8KxHFizB2F2L8r
         PGOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CVZ3s8+W6wLAeEpvBAYhf8iqhQLxzivAvSxjQOV8D5k=;
        fh=V67EcESPDPlpJAFhJ+6Lj1SNPfVuH/8GEPr7vQgmAb0=;
        b=TNiQvWqV1Y3Ztk2Zz5ULU9LfghCDSBLMjKhaIDoH2r7XSk79k7UzDzZVCyoRRhUTy+
         oSU+IBlNXc5lDU9WFq8BkRRveA5haSiIi4oKMg1O4BYnhfkOK2sl3nz5eZtOO/V+A24Z
         EiSRpOQKn4kW68BaJ/HTKTpPateba1fe9kYgxBu2Q8+pM/FEcz/n4utS6Vz/Ef/85sVv
         Bgt/EEILMm6YSFQZhUZaISZBTOKzQKZqiMtiPmRj2qIhIlX6VmzkubUMsQ4tglkw+6ZG
         idPVNrEmqNRRF5C859TvrWa2+VK/Zd4ENn/lpsAtrMvqJq9Pp5JFlQ4zZPnefiB7BDuE
         fR0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786119174; x=1786723974; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CVZ3s8+W6wLAeEpvBAYhf8iqhQLxzivAvSxjQOV8D5k=;
        b=n2jyX5lhPEt5lgc1TubnPPIYSBQ1PT9/+YnTA5qAyj7NKAFma8FikuWg7IZPJH8MY2
         VLwNha2C9aqRjmiyhuL5zXmbK3JDnW1cuxPZE3N4zKq9/jFQc1G8pJrzEF3kmrWupv1Y
         U9lZur6rrKZfSl4PFzv3sORqnI7hNDbh2nmdM0HXCj/LvkF70G+7RB8OTAYFo4fgFX+u
         ftQvUclOA6vRBcOvwPtrU5wwdvRZ/viFF6qykoUiQdUMy+ql9rOYfanqr5iap1pjNoB6
         +q5LR906cip5zXjV/x9XBGhlJBPk4GZTyHpDfyY6vQ4dQ217NaKdQZGvNz12mNMDyu5C
         o7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786119174; x=1786723974;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CVZ3s8+W6wLAeEpvBAYhf8iqhQLxzivAvSxjQOV8D5k=;
        b=R6AytpOwIJ4Vf1W8WLSxEe1P00hYjQiX0gtyjt17c5Gm7Au/4zvpxO2npRwix+ZaLF
         WvmKYgCstQLSIaswA7JpUAqWLQVRoammLfZ06APWAhdm3zM9UqcToIEsWGF8vd7ODhzm
         J3/KvyEYo0yCosLXspdVh7M1EaydTH4AmBjQaxPwXAe+lUlwQU7cvL7RwaOJZ2/Ar4tm
         YWRWFN3wlcJ6W3fYv8YGaHUBaa7p5NGEPLYyRlpWXVqRaJDpa2LI1ZysQptxBpv8SSRp
         r38rsMg3YYlTKM0adrqP4RIWdHRq2y3LvTfmFMtAOivdN0Hyi2G/aUEHgKAGUTVCXq8Y
         smHA==
X-Forwarded-Encrypted: i=1; AHgh+RrsEsxXnTyfG0F8ou70Hja0JMpKpMX7AKheHK5CzDUuaF6VQIiI8uOtaXEvwCp/2VgARbQZfN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn5Q8PiMLjYmCpcwjYba7EJulpftrnPAVJ5Qk6Q+FWtxVJcNJb
	YWWQZ7PLGBF0b18iQHhFTSX9/8iWQOESo4YcCO1Ir/DR/yaouhR7c4Bmd6mKKKaF8eFmOVEKjiM
	MTbwfSG68KM0cniuCUqAP+JtBqFK4ly8=
X-Gm-Gg: AR+sD10s1z0hnf0tgbUoR9f52MoTkkCsEeSxq4N8L5WVLsCZuD0t8zHx19nMkNHAXaN
	HMLfxyk+KUrXgQg0WZSYl8EX+XbjVR0dynXLbXYDwZ1rWL5A9ykTMU/hW1dHA1N2dr12OliSVyN
	FXVvZ+/qD8HCqnp1YswU+nrChsgCsAmemPuAFt/VJ2Q8j6C1H4wQVlnOT+nE3hzVX3AzOwQZyHG
	c/MKKSPiJm7TSVugSZheGYuTsLOUnFHJEyZsOGqY9t7viX5mnSSqw7lPCtJAMywp9t1yF0PaxRM
	9wz+7YJFy/K1kbTYV/ClReEUyieM2Xj46F7rUlz3+OW1/w/EMiHff1s3bO2vLQGmSfLDYeqhGRv
	YL8Ol1fa8XYFVwTRxtEumPhdN4dC3cbA=
X-Received: by 2002:a05:690c:4d89:b0:80e:dc2:873b with SMTP id
 00721157ae682-8259860cf01mr7611667b3.16.1786119174329; Fri, 07 Aug 2026
 09:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807101529.17348-1-baul.lee@xbow.com>
In-Reply-To: <20260807101529.17348-1-baul.lee@xbow.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 7 Aug 2026 12:12:43 -0400
X-Gm-Features: AUfX_mypSIQqGfHUVtlQhC9PiRr-Glq80LV76qSLr4GhgQJcG-dLER3roUrIb7U
Message-ID: <CABBYNZK8sfUkhMSwJ-G8F7z_hGkQKy+Yu9nrbU0cfbzA4vQ0CQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Bluetooth: MGMT: fix use-after-free of struct mgmt_mesh_tx
To: Baul Lee <baul.lee@xbow.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Brian Gix <brian.gix@intel.com>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, Dmitry Antipov <dmantipov@yandex.ru>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, federico.kirschbaum@xbow.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Baul,

On Fri, Aug 7, 2026 at 6:15=E2=80=AFAM Baul Lee <baul.lee@xbow.com> wrote:
>
> hdev->mesh_pending is extended and walked from syscall context under
> hdev->lock, and unlinked and freed from the hci_cmd_sync worker under
> hci_req_sync_lock, so the list has no protection; the objects on it are
> also handed to hci_cmd_sync_queue() as raw pointers, and those work
> entries outlive the list.  Three use-after-frees follow, all reproduced
> under KASAN.
>
> Patch 1 removes mgmt_cleanup(), the one walker of the list that cannot
> take hdev->lock.  Patch 2 puts the list under hdev->lock on the worker
> side and asserts it in the helpers.  Patch 3 gives the object a
> reference count for the work entry.  The order matters: the assertions
> in patch 2 have no violating caller left once patch 1 is in, and the
> reference in patch 3 is only well defined once every unlink happens
> under one lock.
>
> Reaching any of this needs CAP_NET_ADMIN in the init user namespace.
> hci_sock.c sets HCI_SOCK_TRUSTED at bind under capable() rather than
> ns_capable() and gates every later mgmt command on it, and the mesh
> commands additionally need HCI_MESH_EXPERIMENTAL.  Nothing in
> hci_event.c touches hdev->mesh_pending.
>
> Each reproducer was run at identical parameters on the unpatched and the
> patched kernel, built with KASAN, PROVE_LOCKING, DEBUG_LIST and
> DEBUG_ATOMIC_SLEEP: every splat the unpatched kernel produces is gone.
>
> v2: rebased onto bluetooth-next, where send_cancel() no longer ends in
>     mgmt_pending_free(), so v1 did not apply for the CI.  Context only,
>     no other change; v1 applies as posted to the bluetooth tree, which
>     still has that line.
>
> Baul Lee (3):
>   Bluetooth: MGMT: remove the mesh walk from the socket destructor
>   Bluetooth: MGMT: protect hdev->mesh_pending with hdev->lock
>   Bluetooth: MGMT: reference-count struct mgmt_mesh_tx
>
>  include/net/bluetooth/bluetooth.h |  1 -
>  net/bluetooth/hci_sock.c          |  1 -
>  net/bluetooth/mgmt.c              | 72 ++++++++++++++++++++++++---------=
------
>  net/bluetooth/mgmt_util.c         | 31 +++++++++++++++--
>  net/bluetooth/mgmt_util.h         |  3 ++
>  5 files changed, 76 insertions(+), 32 deletions(-)
>
> --
> 2.50.1 (Apple Git-155)

Sashiko found a couple of problems:

https://sashiko.dev/#/patchset/20260807101529.17348-1-baul.lee%40xbow.com

--=20
Luiz Augusto von Dentz
